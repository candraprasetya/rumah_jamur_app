part of '../screens.dart';

class DashBoardScreen extends StatefulWidget {
  final UserModel model;

  const DashBoardScreen({Key key, this.model}) : super(key: key);
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.white,
      body: VxBox(
        child: VStack(
          [
            _title(),
            24.heightBox,
            _grettings(widget.model),
            60.heightBox,
          ],
        ).scrollVertical(),
      ).p16.size(context.screenWidth, context.screenHeight).make(),
    );
  }

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
}
