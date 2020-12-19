part of 'widgets.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onPressed;

  const MyIconButton({Key key, this.icon, this.text, this.onPressed})
      : super(key: key);

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
