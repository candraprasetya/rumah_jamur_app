part of 'models.dart';

class PresensiModel {
  final String code;
  final DateTime start;
  final DateTime end;
  final String uid;
  final String qrUrl;

  PresensiModel({this.code, this.start, this.end, this.uid, this.qrUrl});

  PresensiModel copyWith({String code, DateTime start, DateTime end}) {
    return PresensiModel(
        code: code ?? this.code,
        start: start ?? this.start,
        end: end ?? this.end,
        uid: uid ?? this.uid,
        qrUrl: qrUrl ?? this.qrUrl);
  }
}
