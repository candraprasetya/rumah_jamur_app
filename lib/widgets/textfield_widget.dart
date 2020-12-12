part of 'widgets.dart';

class TextFieldKu extends StatelessWidget {
  final TextEditingController controller;
  final String keterangan;
  TextFieldKu({this.controller, this.keterangan});

  @override
  Widget build(BuildContext context) {
    return VxBox(
            child: TextField(
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: keterangan ?? "Keterangan",
          hintStyle: TextStyle(color: Color(0xFFA0A3BD))),
    ))
        .padding(EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ))
        .width(context.screenWidth)
        .hexColor('#EFF0F6')
        .rounded
        .make();
  }
}
