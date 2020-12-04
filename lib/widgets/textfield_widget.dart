part of 'widgets.dart';

class TextFieldKu extends StatelessWidget {
  final TextEditingController controller;
  final String keterangan;
  TextFieldKu({this.controller, this.keterangan});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: keterangan ?? 'input your email'),
    );
  }
}
