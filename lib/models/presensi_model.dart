part of 'models.dart';

class PresensiModel {
  final String code;
  final DateTime start;
  final DateTime end;
  final String judulKegiatan;
  final String keterangan;
  final String qrUrl;

  PresensiModel(
      {this.code,
      this.start,
      this.end,
      this.judulKegiatan,
      this.keterangan,
      this.qrUrl});

  PresensiModel copyWith({String code, DateTime start, DateTime end}) {
    return PresensiModel(
        code: code ?? this.code,
        start: start ?? this.start,
        end: end ?? this.end,
        judulKegiatan: judulKegiatan ?? this.judulKegiatan,
        keterangan: keterangan ?? this.keterangan,
        qrUrl: qrUrl ?? this.qrUrl);
  }
}
