part of 'widgets.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Color color;
  final Color textColor;
  MyButton(
      {this.text, this.onPress, this.color, this.textColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    return VxBox(
            child: text.text
                .color(textColor)
                .textStyle(primaryText)
                .xl
                .makeCentered())
        .width(context.screenWidth)
        .p16
        .linearGradient([
          color.withOpacity(.9) ?? Warna.primary,
          color?.withOpacity(.7) ?? Warna.primary.withOpacity(.7),
        ])
        .roundedLg
        .border(width: 1, color: color)
        .make()
        .onTap(onPress ?? () {});
  }
}
