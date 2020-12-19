part of 'screens.dart';

class DashBoardScreen extends StatefulWidget {
  final UserModel model;

  const DashBoardScreen({Key key, this.model}) : super(key: key);
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.white,
      body: VxBox(
        child: VStack(
          [
            _title(),
            24.heightBox,
            _grettings(widget.model),
            60.heightBox,
            FutureBuilder<KehadiranModel>(
                future: PresensiService.getCount(widget.model.uid),
                builder: (context, snapshot) {
                  return PieChart(
                    PieChartData(
                        pieTouchData:
                            PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex =
                                  pieTouchResponse.touchedSectionIndex;
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(snapshot.data.kehadiran,
                            snapshot.data.izin, snapshot.data.bolos)),
                  ).centered();
                }),
            VStack([
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
            ])
          ],
        ).scrollVertical(),
      ).size(context.screenWidth, context.screenHeight).make(),
    );
  }

  List<PieChartSectionData> showingSections(
      double hadir, double izin, double bolos) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
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

  Widget _title() {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
          text: 'Rumah',
          style: boldText.copyWith(
            fontSize: 30,
            color: Warna.primary,
          ),
          children: [
            TextSpan(
              text: 'Jamur',
              style: lightText.copyWith(
                fontSize: 30,
                color: Warna.gainsboro,
              ),
            ),
          ]),
    );
  }

  Widget _grettings(UserModel user) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
          text: 'Selamat ${greeting()}, ',
          style: lightText,
          children: [
            TextSpan(
              text: '\n${user.nama}',
              style: primaryText.copyWith(
                fontSize: 18,
                color: Warna.accent,
              ),
            ),
          ]),
    );
  }
}
