part of 'screens.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return MyButton(
      color: Warna.primary,
      text: 'Masuk',
      onPress: () async {
        String email = emailController.text.trim();
        String password = passController.text.trim();
        if (email.isNullOrBlank || password.isNullOrBlank) {
          Get.snackbar('Error', "Silahkan isi email dan password kamu");
        } else {
          Get.dialog(
              BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 18, sigmaX: 18),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Warna.primary),
                ).centered(),
              ),
              barrierColor: Warna.white.withOpacity(.2),
              barrierDismissible: false,
              transitionCurve: Curves.easeOutQuint);
          Result result = await AuthServices.signInEmail(email, password);
          if (result.userModel != null) {
            Get.offAllNamed('/home');
          } else {
            Get.back();
            Get.snackbar('Error', result.message);
          }
        }
      },
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Get.offAndToNamed('/register');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Warna.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Rum',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Warna.primary,
          ),
          children: [
            TextSpan(
              text: 'ah',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Jamur',
              style: TextStyle(color: Warna.primary, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        TextFieldKu(
          keterangan: "Enter your email",
          controller: emailController,
          inputType: TextInputType.emailAddress,
        ),
        10.heightBox,
        TextFieldKu(
          keterangan: "Enter your password",
          controller: passController,
          inputType: TextInputType.visiblePassword,
          isPassword: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .20,
              right: -MediaQuery.of(context).size.width * .4,
              child: MyContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
