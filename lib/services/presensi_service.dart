part of 'services.dart';

class PresensiService {
  static CollectionReference presensiCollection =
      FirebaseFirestore.instance.collection('presensi');
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updatePresensi(PresensiModel presensi) async {
    presensiCollection.doc(presensi.code).update({
      'code': presensi.code,
      'start': presensi.start,
      'end': presensi.end,
      'judulKegiatan': presensi.judulKegiatan,
      'keterangan': presensi.keterangan,
      'qrUrl': presensi.qrUrl,
    });
  }

  static Future<void> setPresensi(PresensiModel presensi) async {
    presensiCollection.doc(presensi.code).set({
      'code': presensi.code,
      'start': presensi.start ?? DateTime.now().millisecondsSinceEpoch,
      'end': presensi.end ?? DateTime.now().millisecondsSinceEpoch,
      'judulKegiatan': presensi.judulKegiatan ?? '',
      'keterangan': presensi.keterangan ?? '',
      'qrUrl': presensi.qrUrl ?? '',
    });
  }

  static Future<void> deletePresensi(String code) async {
    presensiCollection.doc(code).delete();
  }

  static Future<void> userPresensi(String code, String uid) async {
    userCollection.doc(uid).collection('presensi').doc(code).set({
      'code': code,
      'uid': uid,
      'izin': false,
      'keteranganIzin': '',
      'date': DateTime.now().millisecondsSinceEpoch
    });
  }

  static Future<void> userIzin(String code, String uid, String ket) async {
    userCollection
        .doc(uid)
        .collection('presensi')
        .doc(code)
        .update({
          'izin': true,
          'keteranganIzin': ket,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<bool> checkPresensi(String code) async {
    DocumentSnapshot snapshot = await presensiCollection.doc(code).get();

    return snapshot.exists;
  }

  static Future<KehadiranModel> getCount(String uid) async {
    QuerySnapshot snapshotAll =
        await userCollection.doc(uid).collection('presensi').get();

    QuerySnapshot snapshotKehadiran = await userCollection
        .doc(uid)
        .collection('presensi')
        .where('izin', isEqualTo: false)
        .get();

    QuerySnapshot snapshotIzin = await userCollection
        .doc(uid)
        .collection('presensi')
        .where('izin', isEqualTo: true)
        .get();

    QuerySnapshot snapshot = await presensiCollection.get();

    return KehadiranModel(
        snapshotKehadiran.size.toDouble(),
        snapshotIzin.size.toDouble(),
        snapshot.size.toDouble() - snapshotAll.size.toDouble());
  }

  static Future<List<PresensiModel>> getPresensi(
      String code, String uid) async {
    QuerySnapshot snapshot =
        await presensiCollection.doc(code).collection('kehadiran').get();
    var documents =
        snapshot.docs.where((element) => element.data()['uid'] == uid);

    List<PresensiModel> presensi = [];
    for (var document in documents) {
      presensi.add(PresensiModel(
          code: document.data()['code'],
          start: DateTime.fromMillisecondsSinceEpoch(document.data()['start']),
          end: DateTime.fromMillisecondsSinceEpoch(document.data()['end']),
          judulKegiatan: document.data()['judulKegiatan'],
          keterangan: document.data()['keterangan']));
    }

    return presensi;
  }
}
