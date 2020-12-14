part of 'screens.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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
        text: 'Daftar',
        color: Warna.primary,
        onPress: () async {
          String email = emailController.text;
          String password = passController.text;
          String nim = nimController.text;
          String nama = nameController.text;
          if (email.isEmpty ||
              password.isEmpty ||
              nama.isEmpty ||
              nim.isEmpty) {
            Get.snackbar('Error', "Silahkan isi data kamu",
                backgroundColor: Warna.red, colorText: Warna.white);
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
            Result result = await AuthServices.createUserWithEmailAndPassword(
                email,
                password,
                UserModel(
                    nama: nama,
                    nim: nim.toUpperCase(),
                    photoUrl:
                        "https://sia.unram.ac.id/index.php/foto/mahasiswa/" +
                            nim.toUpperCase() +
                            "/300/300"));
            if (result.userModel != null) {
              Get.offAllNamed('/home');
            } else {
              Get.back();
              Get.snackbar('Error', result.message,
                  backgroundColor: Warna.red, colorText: Warna.white);
            }
          }
        });
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Get.offAndToNamed('/login');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sudah Punya Akun ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Masuk',
              style: TextStyle(
                  color: Color(0xfff79c4f),
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
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ah',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Jamur',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        TextFieldKu(
          controller: nameController,
          keterangan: 'inputkan nama',
          inputType: TextInputType.name,
        ),
        10.heightBox,
        TextFieldKu(
          controller: nimController,
          keterangan: 'inputkan nim',
          inputType: TextInputType.text,
        ),
        10.heightBox,
        TextFieldKu(
          controller: emailController,
          keterangan: 'inputkan email',
          inputType: TextInputType.emailAddress,
        ),
        10.heightBox,
        TextFieldKu(
          controller: passController,
          keterangan: 'inputkan password',
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
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: MyContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
