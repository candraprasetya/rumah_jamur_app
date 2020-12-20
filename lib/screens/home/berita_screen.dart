part of '../screens.dart';

class BeritaScreen extends StatefulWidget {
  @override
  _BeritaScreenState createState() => _BeritaScreenState();
}

class _BeritaScreenState extends State<BeritaScreen> {
  CollectionReference berita = FirebaseFirestore.instance.collection('berita');

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
