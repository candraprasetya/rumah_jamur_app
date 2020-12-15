part of 'models.dart';

class PresensiModel {
  final String code;
  final DateTime start;
  final DateTime end;

  PresensiModel({this.code, this.start, this.end});

  PresensiModel copyWith({String code, DateTime start, DateTime end}) {
    return PresensiModel(
        code: code ?? this.code,
        start: start ?? this.start,
        end: end ?? this.end);
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'start': start,
      'end': end,
    };
  }

  factory PresensiModel.fromDoc(DocumentSnapshot doc) {
    if (doc == null) return null;

    return PresensiModel(
        code: doc.data()['code'],
        start: doc.data()['start'],
        end: doc.data()['end']);
  }

  String toJson() => json.encode(toMap());

  factory PresensiModel.fromJson(String source) =>
      PresensiModel.fromDoc(json.decode(source));

  @override
  String toString() => 'Presensi(Code: $code, Start: $start, End: $end)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PresensiModel &&
        o.code == code &&
        o.start == start &&
        o.end == end;
  }

  @override
  int get hashCode => code.hashCode ^ start.hashCode ^ end.hashCode;
}
