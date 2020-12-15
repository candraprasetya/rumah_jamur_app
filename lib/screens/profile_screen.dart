part of 'screens.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MyButton(
      color: Warna.red,
      text: 'Keluar',
      onPress: () {
        AuthServices.signOut();
        Get.offAllNamed('/welcome');
      },
    ).objectCenter());
  }
}
