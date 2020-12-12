part of 'widgets.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Color color;
  MyButton({this.text, this.onPress, this.color});
  @override
  Widget build(BuildContext context) {
    return VxBox(child: text.text.white.xl.makeCentered())
        .width(context.screenWidth)
        .p16
        .linearGradient([
          color ?? Color(0xffcd6133),
          color?.withOpacity(.7) ?? Color(0xffcd6133).withOpacity(.7),
        ])
        .roundedLg
        .make()
        .onTap(onPress ?? () {});
  }
}
