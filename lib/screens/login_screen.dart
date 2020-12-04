part of 'screens.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VStack([
        TextFieldKu(
          controller: emailController,
          keterangan: 'inputkan email',
        ),
        TextFieldKu(
          controller: passController,
          keterangan: 'inputkan password',
        ),
        RaisedButton(
          child: 'Masuk'.text.white.makeCentered(),
          onPressed: () async {
            //FIXME memanggil fungsi register dari AuthService
            FirebaseAuth auth = FirebaseAuth.instance;
            await auth.signInWithEmailAndPassword(
                email: emailController.text, password: passController.text);
          },
        )
      ]),
    );
  }
}
