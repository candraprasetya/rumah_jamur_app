part of 'screens.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.white,
      body: VStack([
        'Presensi Berhasil'.text.xl4.makeCentered(),
        MyButton(
          text: 'Kembali Ke Halaman Utama',
          color: Warna.accent,
          onPress: () {
            Get.offAndToNamed('/home');
          },
        )
      ]),
    );
  }
}
