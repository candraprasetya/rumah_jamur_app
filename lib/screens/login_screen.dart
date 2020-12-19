part of 'screens.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

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
            Get.offAllNamed('/home', arguments: result.userModel.uid);
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
          child: HStack(
            [
              'Bellum punya akun?'
                  .text
                  .textStyle(primaryText.copyWith(fontSize: 14))
                  .make(),
              6.widthBox,
              'Daftar disini'
                  .text
                  .textStyle(
                      boldText.copyWith(fontSize: 14, color: Warna.accent))
                  .make()
            ],
            alignment: MainAxisAlignment.center,
          )),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Rumah',
          style: boldText.copyWith(fontSize: 28, color: Warna.darkBrown),
          children: [
            TextSpan(
                text: 'Jamur',
                style:
                    lightText.copyWith(fontSize: 28, color: Warna.darkBrown)),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return VStack([
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: VxBox(
      child: ZStack(
        [
          Positioned(
              top: -context.screenHeight * .20,
              right: -context.screenWidth * .4,
              child: MyContainer()),
          VxBox(
            child: VStack(
              [
                (context.screenHeight * .2).heightBox,
                _title(),
                52.heightBox,
                _emailPasswordWidget(),
                24.heightBox,
                _submitButton(),
                'Forgot Password ?'
                    .text
                    .textStyle(boldText)
                    .make()
                    .p12()
                    .objectCenterRight(),
                _createAccountLabel().objectBottomCenter(),
              ],
              alignment: MainAxisAlignment.center,
              crossAlignment: CrossAxisAlignment.center,
              axisSize: MainAxisSize.max,
            ).scrollVertical(),
          ).make().p12(),
          BackButtonWidget(
            title: 'Back',
            iconData: Icons.arrow_back_ios_outlined,
            onPressed: () => Get.back(),
          ),
        ],
      ),
    ).make());
  }
}
