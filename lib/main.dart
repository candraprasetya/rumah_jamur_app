//import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_jamur/screens/screens.dart';

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
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            initialRoute: '/login',
            getPages: [
              GetPage(name: '/wrapper', page: () => Wrapper()),
              GetPage(name: '/login', page: () => LoginScreen())
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
