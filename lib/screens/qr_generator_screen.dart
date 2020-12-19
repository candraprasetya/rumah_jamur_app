part of 'screens.dart';

class QrGeneratorScreen extends StatefulWidget {
  @override
  _QrGeneratorScreenState createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  TextEditingController code = TextEditingController();
  TextEditingController judul = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  Uint8List bytes = Uint8List(0);
  String uid = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.white,
      body: VStack(
        [
          SafeArea(
              child: VxBox(
                      child: HStack(
            [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  }),
              'Tambah Jadwal'
                  .text
                  .textStyle(boldText)
                  .maxLines(1)
                  .makeCentered(),
            ],
          ))
                  .padding(EdgeInsets.symmetric(
                    horizontal: 12,
                  ))
                  .size(context.screenWidth, context.percentHeight * 12)
                  .color(Warna.white)
                  .make()),
          VStack(
            [
              TextFieldKu(
                keterangan: "Judul Kegiatan",
                controller: judul,
                inputType: TextInputType.text,
              ),
              10.heightBox,
              TextFieldKu(
                keterangan: "Keterangan Kegiatan",
                controller: keterangan,
                inputType: TextInputType.text,
              ),
              10.heightBox,
              MyButton(
                color: Warna.red,
                text: 'Generate Code',
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
                  String randomCode = randomAlpha(6);
                  Uint8List result = await scanner.generateBarCode(randomCode);
                  String url = await uploadQR(randomCode, uid, result);
                  if (!url.isEmptyOrNull) {
                    await PresensiService.setPresensi(PresensiModel(
                        code: randomCode,
                        start: DateTime.now(),
                        end: DateTime.now().add(Duration(hours: 2)),
                        judulKegiatan: judul.text.trim(),
                        keterangan: keterangan.text.trim(),
                        qrUrl: url));
                  }
                  Get.offAllNamed('/qrview', arguments: [result, randomCode]);
                },
              ).objectBottomCenter(),
            ],
            axisSize: MainAxisSize.max,
            alignment: MainAxisAlignment.center,
          ).p16()
        ],
        axisSize: MainAxisSize.max,
        crossAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
