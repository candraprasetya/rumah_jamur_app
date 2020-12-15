//import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_jamur/screens/screens.dart';
import 'package:velocity_x/velocity_x.dart';

//fungsi main
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

//widget app
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init,
      builder: (context, snapshot) {
        //No Internet
        if (snapshot.hasError) {
          return Text('Cek Koneksi Internet Kamu');
        }
        //Main App
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/welcome',
            getPages: [
              GetPage(name: '/success', page: () => SuccessScreen()),
              GetPage(name: '/code', page: () => CodePresensi()),
              GetPage(name: '/qr', page: () => QrPresensi()),
              GetPage(name: '/welcome', page: () => WelcomeScreen()),
              GetPage(name: '/login', page: () => LoginScreen()),
              GetPage(name: '/register', page: () => RegisterScreen()),
              GetPage(name: '/home', page: () => HomeScreen()),
              GetPage(name: '/profile', page: () => ProfileScreen()),
              GetPage(name: '/presensi', page: () => PresensiScreen())
            ],
          );
        }
        //Loading
        return Container(
          color: Colors.white,
        );
      },
    );
  }
}
