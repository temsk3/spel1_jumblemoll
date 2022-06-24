import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'supporter_model.freezed.dart';
part 'supporter_model.g.dart';

// firestore から受け取った Timestamp型を DateTime型に変換するためにJsonKeyを作成 @timestamp DateTime
DateTime? dateFromTimestampValue(dynamic value) =>
    value != null ? (value as Timestamp).toDate() : null;

Timestamp? timestampFromDateValue(dynamic value) =>
    value is DateTime ? Timestamp.fromDate(value) : null;

const timestampkey = JsonKey(
  fromJson: dateFromTimestampValue,
  toJson: timestampFromDateValue,
);

@freezed
class Supporter with _$Supporter {
  const Supporter._();

  const factory Supporter({
    String? uid,
    required String? name,
    required bool? isActive,
    @timestampkey DateTime? createdAt,
    @timestampkey DateTime? updatedAt,
    @timestampkey DateTime? deletedAt,
    String? eventId,
  }) = _Supporter;

  factory Supporter.fromJson(Map<String, dynamic> json) =>
      _$SupporterFromJson(json);
}
