part of 'models.dart';

class BeritaModel {
  final String code;
  final String judul;
  final String imageUrl;
  final String content;
  final String uid;
  final String nama;
  final DateTime date;

  BeritaModel(
      {this.code,
      this.judul,
      this.imageUrl,
      this.content,
      this.uid,
      this.nama,
      this.date});
}
