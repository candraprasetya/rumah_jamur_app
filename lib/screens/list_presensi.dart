part of 'screens.dart';

class ListPresensi extends StatefulWidget {
  @override
  _ListPresensiState createState() => _ListPresensiState();
}

class _ListPresensiState extends State<ListPresensi> {
  CollectionReference presensis =
      FirebaseFirestore.instance.collection('presensi');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.white,
      body: VStack([
        SafeArea(
            child: VxBox(
                    child: HStack(
          [
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                }),
            'List Jadwal'.text.textStyle(boldText).maxLines(1).makeCentered(),
            IconButton(
                icon: Icon(Icons.add_outlined),
                onPressed: () {
                  Get.toNamed('/qr');
                }).objectCenterRight(),
          ],
          alignment: MainAxisAlignment.spaceBetween,
          axisSize: MainAxisSize.max,
        ))
                .py12
                .size(context.screenWidth, context.percentHeight * 12)
                .color(Warna.white)
                .make()),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: presensis.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return ErrorScreen();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Warna.primary),
                ).centered();
              }

              return ListView(
                scrollDirection: Axis.vertical,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return VxBox(
                          child: VStack([
                    Text(
                      document.data()['code'],
                      style: boldText.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    Text(document.data()['judulKegiatan'],
                        style: primaryText.copyWith(
                            fontSize: 14,
                            color: Warna.darkBrown.withOpacity(.7))),
                    16.heightBox,
                    HStack(
                      [
                        Text(
                            DateFormat.yMMMd()
                                .add_jm()
                                .format(DateTime.parse(document
                                    .data()['start']
                                    .toDate()
                                    .toString()))
                                .toString(),
                            style: primaryText.copyWith(
                                fontSize: 12,
                                color: Warna.darkBrown.withOpacity(.7))),
                        Icon(
                          Icons.delete_outline_rounded,
                          color: Warna.red,
                        ).objectBottomRight().onTap(() async {
                          await PresensiService.deletePresensi(
                              document.data()['code']);
                        }),
                      ],
                      alignment: MainAxisAlignment.spaceBetween,
                      axisSize: MainAxisSize.max,
                    )
                  ]))
                      .roundedSM
                      .color(Warna.lynxWhite)
                      .p16
                      .make()
                      .wFull(context)
                      .pSymmetric(v: 8, h: 16)
                      .onTap(() {
                    Get.toNamed('/qrview', arguments: [
                      Uint8List(0),
                      document.data()['code'],
                      document.data()['qrUrl']
                    ]);
                  });
                }).toList(),
              );
            },
          ),
        ),
      ]),
    );
  }
}
