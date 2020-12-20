part of '../screens.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key key, this.model}) : super(key: key);

  final UserModel model;

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  CollectionReference berita = FirebaseFirestore.instance.collection('berita');
  int touchedIndex;

  Widget _title() {
    return RichText(
      textAlign: TextAlign.start,
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

  Widget _grettings(UserModel user) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
          text: 'Selamat ${greeting()}, ',
          style: primaryText,
          children: [
            TextSpan(
              text: '\n${user.nama}',
              style: boldText.copyWith(
                fontSize: 18,
                color: Warna.accent,
              ),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: VStack(
        [
          VStack([
            _title(),
            16.heightBox,
            _grettings(widget.model),
            40.heightBox,
            'Informasi Terbaru'
                .text
                .textStyle(
                    boldText.copyWith(color: Warna.darkBrown, fontSize: 10))
                .make()
                .objectCenterRight()
          ]).p16(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: berita.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            child: HStack([
                      VxBox(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: CachedNetworkImage(
                                    imageUrl: document.data()['imageUrl'],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        new CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Warna.primary))
                                            .p12(),
                                    errorWidget: (context, url, error) =>
                                        new Icon(
                                      Icons.error_outlined,
                                      color: Warna.white,
                                    ),
                                  )))
                          .rounded
                          .size(context.percentWidth * 22,
                              context.percentWidth * 22)
                          .color(Warna.white)
                          .make()
                          .onTap(() async {}),
                      16.widthBox,
                      VStack([
                        Text(
                                DateFormat.yMMMMd().format(
                                    DateTime.fromMicrosecondsSinceEpoch(
                                        document.data()['date'] * 1000)),
                                style: primaryText.copyWith(
                                    fontSize: 10,
                                    color: Warna.darkBrown.withOpacity(.7)))
                            .objectCenterRight(),
                        10.heightBox,
                        Text(
                          document.data()['judul'],
                          style: boldText.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        4.heightBox,
                        Text(document.data()['content'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: primaryText.copyWith(
                                fontSize: 14,
                                color: Warna.darkBrown.withOpacity(.7))),
                      ], axisSize: MainAxisSize.max),
                      10.heightBox,
                    ]))
                        .roundedSM
                        .color(Warna.lynxWhite)
                        .p16
                        .make()
                        .wFull(context)
                        .pSymmetric(v: 8, h: 16)
                        .onTap(() async {
                      Get.toNamed('/detail', arguments: [
                        document.data()['nama'],
                        document.data()['nim'],
                        document.data()['uid']
                      ]);
                    });
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    ).make().whFull(context);
  }
}
