part of 'screens.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      Future.delayed(Duration.zero, () {
        Get.offAllNamed('/home', arguments: auth.currentUser.uid);
      });
    }
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Welcome to \n\n',
          style: boldText.copyWith(fontSize: 20),
          children: [
            TextSpan(
              text: 'Rumah',
              style: boldText.copyWith(fontSize: 28),
            ),
            TextSpan(
                text: 'Jamur',
                style: lightText.copyWith(fontSize: 28, color: Colors.white)),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
              child: ZStack([
        _title().objectCenter(),
        VStack([
          80.heightBox,
          MyButton(
            color: Warna.white,
            textColor: Vx.gray800,
            text: 'Masuk',
            onPress: () {
              Get.toNamed('/login');
            },
          ),
          20.heightBox,
          MyButton(
            color: Warna.darkBrown,
            textColor: Warna.white,
            text: 'Daftar',
            onPress: () {
              Get.toNamed('/register');
            },
          ),
        ],
            alignment: MainAxisAlignment.end,
            crossAlignment: CrossAxisAlignment.center,
            axisSize: MainAxisSize.max),
      ]))
          .linearGradient([Warna.primary, Warna.accent])
          .p16
          .make()
          .whFull(context),
    );
  }
}
