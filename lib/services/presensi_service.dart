part of 'services.dart';

class PresensiService {
  static CollectionReference presensiCollection =
      FirebaseFirestore.instance.collection('presensi');
  static Future<void> updatePresensi(PresensiModel presensi) async {
    presensiCollection.doc(presensi.code).update(
        {'code': presensi.code, 'start': presensi.start, 'end': presensi.end});
  }

  static Future<void> setPresensi(PresensiModel presensi) async {
    presensiCollection.doc(presensi.code).set({
      'code': presensi.code,
      'start': presensi.start ?? DateTime.now().millisecondsSinceEpoch,
      'end': presensi.end ?? DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> userPresensi(String code, String uid) async {
    presensiCollection
        .doc(code)
        .collection(uid)
        .doc()
        .set({'code': code, 'uid': uid, 'date': DateTime.now()});
  }

  static Future<bool> getPresensi(String code) async {
    DocumentSnapshot snapshot = await presensiCollection.doc(code).get();

    return snapshot.exists;
  }
}
