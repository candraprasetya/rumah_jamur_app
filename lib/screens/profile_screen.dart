part of 'screens.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;
  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int touchedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Warna.white,
        body: VStack([
          20.heightBox,
          widget.user.nama.text.textStyle(boldText).xl2.make().px16(),
          20.heightBox,
          "Email : ${widget.user.email}"
              .text
              .textStyle(primaryText)
              .xs
              .make()
              .px16(),
          10.heightBox,
          "Nim : ${widget.user.nim}"
              .text
              .textStyle(primaryText)
              .xs
              .make()
              .px16(),
          20.heightBox,
          FutureBuilder<KehadiranModel>(
              future: PresensiService.getCount(widget.user.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ErrorScreen();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Warna.primary),
                  ).centered();
                }
                return VStack([
                  HStack(
                    [
                      Indicator(
                        color: Warna.blue,
                        size: 12,
                        text: 'Hadir',
                        textColor: Warna.darkBrown,
                        isSquare: false,
                      ),
                      Indicator(
                        color: Warna.green,
                        size: 12,
                        text: 'Izin',
                        textColor: Warna.darkBrown,
                        isSquare: false,
                      ),
                      Indicator(
                        color: Warna.red,
                        size: 12,
                        text: 'Tidak Hadir',
                        textColor: Warna.darkBrown,
                        isSquare: false,
                      )
                    ],
                    axisSize: MainAxisSize.max,
                    alignment: MainAxisAlignment.spaceAround,
                  ),
                  PieChart(
                    PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 4,
                        centerSpaceRadius: 40,
                        sections: showingSections(snapshot.data.kehadiran,
                            snapshot.data.izin, snapshot.data.bolos)),
                  ).centered(),
                ], alignment: MainAxisAlignment.spaceBetween);
              }),
          20.heightBox,
          (widget.user.role == "panitia")
              ? MyButton(
                  color: Warna.blue,
                  text: 'Lihat Jadwal',
                  onPress: () {
                    Get.toNamed('/jadwal', arguments: widget.user.uid);
                  },
                )
              : 16.heightBox,
          16.heightBox,
          (widget.user.role == "panitia")
              ? MyButton(
                  color: Warna.green,
                  text: 'Lihat Peserta',
                  onPress: () {
                    Get.toNamed('/peserta');
                  },
                )
              : 16.heightBox,
          16.heightBox,
          MyButton(
            color: Warna.red,
            text: 'Keluar',
            onPress: () {
              AuthServices.signOut();
              Get.offAllNamed('/welcome');
            },
          ),
          16.heightBox,
        ]).scrollVertical());
  }

  List<PieChartSectionData> showingSections(
      double hadir, double izin, double bolos) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 24 : 14;
      final double radius = isTouched ? 46 : 40;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Warna.blue,
            value: hadir ?? 0,
            title: hadir <= 0 ? '' : hadir.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Warna.white),
          );
        case 1:
          return PieChartSectionData(
            color: Warna.green,
            value: izin ?? 0,
            title: izin <= 0 ? '' : izin.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Warna.white),
          );
        case 2:
          return PieChartSectionData(
            color: Warna.red,
            value: bolos ?? 0,
            title: bolos <= 0 ? '' : bolos.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Warna.white),
          );

        default:
          return null;
      }
    });
  }
}
