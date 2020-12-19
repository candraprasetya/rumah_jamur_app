part of 'models.dart';

class UserModel {
  final String uid;
  final String nama;
  final String nim;
  final String email;
  final String photoUrl;
  final String noTelephone;
  final String role;
  final double kehadiran;
  final double izin;
  final double bolos;

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
