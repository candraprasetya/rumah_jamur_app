part of 'services.dart';

class UserServices {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(UserModel user) async {
    userCollection.doc(user.uid).update({
      'nama': user.nama,
      'nim': user.nim,
      'noTelephone': user.noTelephone,
      'photoUrl': user.photoUrl ?? '',
    });
  }

  static Future<void> setUser(UserModel user) async {
    userCollection.doc(user.uid).set({
      'email': user.email,
      'nama': user.nama,
      'nim': user.nim,
      'noTelephone': user.noTelephone,
      'photoUrl': user.photoUrl ?? '',
    });
  }

  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await userCollection.doc(id).get();

    Map<String, dynamic> data = snapshot.data();

    return UserModel(
        uid: id,
        email: data['email'],
        nama: data['nama'],
        nim: data['nim'],
        noTelephone: data['noTelephone'],
        photoUrl: data['photoUrl']);
  }
}
