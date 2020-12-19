part of 'screens.dart';

class ErrorScreen extends StatefulWidget {
  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
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
          Lottie.asset('assets/animations/oops.json').wh48(context).centered(),
          10.heightBox,
          'Something went wrong'.text.color(Warna.red).xl4.makeCentered(),
          20.heightBox,
          MyButton(
            text: 'Kembali Ke Halaman Utama',
            color: Warna.accent,
            onPress: () {
              Get.offAllNamed('/home');
            },
          ).p16()
        ], alignment: MainAxisAlignment.center)
            .hFull(context),
      ),
    );
  }
}
