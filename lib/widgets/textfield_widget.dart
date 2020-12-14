part of 'widgets.dart';

class TextFieldKu extends StatelessWidget {
  final TextEditingController controller;
  final String keterangan;
  final TextInputType inputType;
  final bool isPassword;
  TextFieldKu(
      {this.controller, this.keterangan, this.inputType, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return VxBox(
            child: TextField(
      controller: controller,
      keyboardType: inputType ?? TextInputType.text,
      obscureText: isPassword ?? false,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: keterangan ?? "Keterangan",
          hintStyle: TextStyle(color: Color(0xFFA0A3BD), fontSize: 12)),
    ))
        .padding(EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 6,
        ))
        .width(context.screenWidth)
        .hexColor('#EFF0F6')
        .rounded
        .make();
  }
}
