part of 'screens.dart';

class CodePresensi extends StatefulWidget {
  @override
  _CodePresensiState createState() => _CodePresensiState();
}

class _CodePresensiState extends State<CodePresensi> {
  String uid = Get.arguments;
  TextEditingController kodeController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VxBox(
            child: ZStack([
          Positioned(
            top: -MediaQuery.of(context).size.height * .32,
            right: -MediaQuery.of(context).size.width * .4,
            child: MyContainer(),
          ),
          _backButton(),
          VStack(
            [
              'Presensi Dengan Kode'.text.xl4.makeCentered(),
              16.heightBox,
              TextFieldKu(
                controller: kodeController,
                inputType: TextInputType.text,
                keterangan: 'Masukkan kode presensi',
              ),
              20.heightBox,
              MyButton(
                text: 'Presensi Sekarang',
                color: Warna.primary,
                onPress: () async {
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
                  String kode = kodeController.text.trim();
                  bool presensi = await PresensiService.checkPresensi(kode);

                  if (!presensi) {
                    Get.back();
                    Get.snackbar(
                        'Gagal Presensi', 'Kode yang anda masukkan salah');
                  } else {
                    await PresensiService.userPresensi(kode, uid);
                    Get.offAllNamed('/success', arguments: ['', uid, kode]);
                  }
                },
              )
            ],
            alignment: MainAxisAlignment.center,
          ).objectCenter()
        ])).p16.makeCentered(),
      ),
    );
  }
}
