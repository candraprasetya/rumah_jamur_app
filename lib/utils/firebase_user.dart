part of 'utils.dart';

extension FirebaseUserExtension on User {
  Future<UserModel> fromFireStore() async =>
      await UserServices.getUser(this.uid);

  UserModel convertToUser(
          {String email, String nama, String nim, String photoUrl}) =>
      UserModel(
          uid: this.uid,
          email: email,
          nama: nama,
          nim: nim,
          photoUrl: photoUrl);
}
