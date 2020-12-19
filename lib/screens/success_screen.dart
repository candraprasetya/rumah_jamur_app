part of 'screens.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  String tag = Get.arguments[0];
  UserModel userModel = Get.arguments[1];
  String code = Get.arguments[2];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAllNamed('/home');
        return;
      },
      child: Scaffold(
        backgroundColor: Warna.white,
        body: VStack([
          Lottie.asset('assets/animations/success.json')
              .wh48(context)
              .centered(),
          10.heightBox,
          (tag != "izin")
              ? 'Presensi Berhasil'.text.xl4.makeCentered()
              : 'Izin Berhasil'.text.xl4.makeCentered(),
          20.heightBox,
          MyButton(
            text: 'Kembali Ke Halaman Utama',
            color: Warna.accent,
            onPress: () {
              Get.offAndToNamed('/home', arguments: userModel);
            },
          ).p16(),
          8.heightBox,
          (tag != "izin")
              ? RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Tidak dapat hadir? ',
                      style: lightText,
                      children: [
                        TextSpan(
                          text: 'Izin Disini',
                          style: boldText.copyWith(color: Warna.red),
                        ),
                      ]),
                ).objectCenter().onTap(() {
                  Get.offAllNamed('/izin', arguments: [userModel.uid, code]);
                })
              : 0.heightBox,
        ], alignment: MainAxisAlignment.center)
            .hFull(context),
      ),
    );
  }
}
