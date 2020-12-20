part of 'widgets.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({Key key, this.icon, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return VxBox(
            child: VStack([
      Icon(
        icon,
        color: Warna.darkBrown,
      ),
      16.heightBox,
      text.text
          .textStyle(boldText.copyWith(
            color: Warna.blue,
            fontSize: 10,
          ))
          .make()
    ],
                alignment: MainAxisAlignment.center,
                crossAlignment: CrossAxisAlignment.center))
        .p32
        .roundedLg
        .color(Warna.lynxWhite)
        .make()
        .wFull(context)
        .onTap(onPressed);
  }
}
