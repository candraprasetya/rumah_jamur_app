part of 'models.dart';

class UserModel {
  final String uid;
  final String nama;
  final String nim;
  final String email;
  final String photoUrl;
  final String noTelephone;

  UserModel({
    this.uid,
    this.email,
    this.nama,
    this.nim,
    this.photoUrl,
    this.noTelephone,
  });

  UserModel copyWith({
    String uid,
    String nama,
    String nim,
    String email,
    String photoUrl,
    String noTelephone,
  }) {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        nama: nama ?? this.nama,
        nim: nim ?? this.nim,
        photoUrl: photoUrl ?? this.photoUrl,
        noTelephone: noTelephone ?? this.noTelephone);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nama': nama,
      'nim': nim,
      'photoUrl': photoUrl,
      'noTelephone': noTelephone,
    };
  }

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    if (doc == null) return null;

    return UserModel(
      uid: doc.id,
      email: doc.data()['email'],
      nama: doc.data()['name'],
      nim: doc.data()['nim'],
      photoUrl: doc.data()['photo_url'],
      noTelephone: doc.data()['noTelephone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromDoc(json.decode(source));

  @override
  String toString() =>
      'User(id: $uid, name: $nama, email: $email, photoUrl: $photoUrl)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.uid == uid &&
        o.email == email &&
        o.nama == nama &&
        o.nim == nim &&
        o.photoUrl == photoUrl &&
        o.noTelephone == noTelephone;
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      email.hashCode ^
      nama.hashCode ^
      nim.hashCode ^
      photoUrl.hashCode ^
      noTelephone.hashCode;
}
