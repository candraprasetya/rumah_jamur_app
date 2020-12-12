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
      body: VxBox(
        child: formLogin(),
      ).p16.size(context.screenWidth, context.screenHeight).make(),
    );
  }

  Widget formLogin() {
    return VStack(
      [
        TextFieldKu(
          controller: emailController,
          keterangan: 'inputkan email',
        ),
        10.heightBox,
        TextFieldKu(
          controller: passController,
          keterangan: 'inputkan password',
        ),
        20.heightBox,
        MyButton(
          text: 'Masuk',
          onPress: () {
            VxToast.show(context, msg: 'Butotn di click');
          },
        ),
      ],
      alignment: MainAxisAlignment.center,
    );
  }
}
