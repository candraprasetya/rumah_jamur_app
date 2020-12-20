part of 'models.dart';

class UserModel {
  UserModel(
      {this.uid,
      this.email,
      this.nama,
      this.nim,
      this.photoUrl,
      this.noTelephone,
      this.role,
      this.kehadiran,
      this.izin,
      this.bolos});

  final double bolos;
  final String email;
  final double izin;
  final double kehadiran;
  final String nama;
  final String nim;
  final String noTelephone;
  final String photoUrl;
  final String role;
  final String uid;

  UserModel copyWith(
      {String uid,
      String nama,
      String nim,
      String email,
      String photoUrl,
      String noTelephone,
      String role,
      double kehadiran,
      double izin,
      double bolos}) {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        nama: nama ?? this.nama,
        nim: nim ?? this.nim,
        photoUrl: photoUrl ?? this.photoUrl,
        noTelephone: noTelephone ?? this.noTelephone,
        role: role ?? this.role,
        kehadiran: kehadiran ?? this.kehadiran,
        izin: izin ?? this.izin,
        bolos: bolos ?? this.bolos);
  }
}
