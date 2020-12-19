part of '../screens.dart';

class DetailPeserta extends StatefulWidget {
  @override
  _DetailPesertaState createState() => _DetailPesertaState();
}

class _DetailPesertaState extends State<DetailPeserta> {
  String nama = Get.arguments[0];
  String nim = Get.arguments[1];
  String uid = Get.arguments[2];

  @override
  void initState() {
    super.initState();
    nama = Get.arguments[0];
    nim = Get.arguments[1];
    uid = Get.arguments[2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.white,
      body: FutureBuilder<KehadiranModel>(
          future: PresensiService.getCount(uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorScreen();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Warna.primary),
              ).centered();
            }
            return SafeArea(
              child: VStack(
                [
                  VxBox(
                          child: HStack(
                    [
                      IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Get.back();
                          }),
                      'Detail Peserta'
                          .text
                          .textStyle(boldText)
                          .maxLines(1)
                          .makeCentered(),
                    ],
                    axisSize: MainAxisSize.max,
                  ))
                      .py12
                      .size(context.screenWidth, context.percentHeight * 12)
                      .color(Warna.white)
                      .make(),
                  nama.text.textStyle(boldText.copyWith(fontSize: 24)).make(),
                  16.heightBox,
                  nim.text
                      .textStyle(boldText)
                      .color(Warna.darkBrown.withOpacity(.7))
                      .make(),
                  24.heightBox,
                  HStack(
                    [
                      'Total Kehadiran : '.text.textStyle(primaryText).make(),
                      VxBox(
                        child: snapshot.data.kehadiran
                            .toStringAsFixed(0)
                            .text
                            .white
                            .textStyle(boldText.copyWith(fontSize: 32))
                            .make(),
                      ).p32.color(Warna.blue).roundedFull.makeCentered()
                    ],
                    alignment: MainAxisAlignment.spaceBetween,
                    axisSize: MainAxisSize.max,
                  ).p16(),
                  HStack(
                    [
                      'Total Izin : '.text.textStyle(primaryText).make(),
                      VxBox(
                        child: snapshot.data.izin.toStringAsFixed(0).text.white
                            .textStyle(boldText.copyWith(fontSize: 32))
                            .make(),
                      ).p32.color(Warna.green).roundedFull.makeCentered()
                    ],
                    alignment: MainAxisAlignment.spaceBetween,
                    axisSize: MainAxisSize.max,
                  ).p16(),
                  HStack(
                    [
                      'Tidak Hadir : '.text.textStyle(primaryText).make(),
                      VxBox(
                        child: snapshot.data.bolos.toStringAsFixed(0).text.white
                            .textStyle(boldText.copyWith(fontSize: 32))
                            .make(),
                      ).p32.color(Warna.red).roundedFull.makeCentered()
                    ],
                    alignment: MainAxisAlignment.spaceBetween,
                    axisSize: MainAxisSize.max,
                  ).p16()
                ],
                crossAlignment: CrossAxisAlignment.center,
                axisSize: MainAxisSize.max,
              ).scrollVertical(),
            );
          }),
    );
  }
}
