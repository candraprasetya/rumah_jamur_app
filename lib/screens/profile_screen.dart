part of 'screens.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;
  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
}
