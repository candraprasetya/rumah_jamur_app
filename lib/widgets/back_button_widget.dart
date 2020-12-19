part of 'widgets.dart';

class BackButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;
  final String title;
  final Color color;

  const BackButtonWidget(
      {Key key,
      this.iconData,
      this.onPressed,
      this.title,
      this.color = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: VxBox(
                child: HStack(
      [
        Icon(iconData),
        10.widthBox,
        title.text.textStyle(boldText).maxLines(1).make(),
      ],
      crossAlignment: CrossAxisAlignment.center,
      alignment: MainAxisAlignment.start,
    ))
            .p12
            .size(context.screenWidth, context.percentHeight * 10)
            .color(color)
            .make()
            .onTap(onPressed));
  }
}
