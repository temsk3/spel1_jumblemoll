import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

// // firestore から受け取った Timestamp型を DateTime型に変換するためにJsonKeyを作成 @timestamp DateTime
DateTime? dateFromTimestampValue(dynamic value) =>
    value != null ? (value as Timestamp).toDate() : null;

Timestamp? timestampFromDateValue(dynamic value) =>
    value is DateTime ? Timestamp.fromDate(value) : null;

const timestampkey = JsonKey(
  fromJson: dateFromTimestampValue,
  toJson: timestampFromDateValue,
);

//
@freezed
class Order with _$Order {
  const Order._();

  const factory Order({
    String? id,
    String? userId,
    String? userName,
    String? organizer,
    String? bazaarId,
    String? bazaarName,
    int? exchangeNumber,
    String? code,
    required String? name,
    required String? desc,
    required int? price,
    required int? numberOfUse,
    required int? quantity,
    required int? sum,
    String? picture1URL,
    String? picture2URL,
    String? picture3URL,
    @timestampkey required DateTime? expirationFrom,
    @timestampkey required DateTime? expirationTo,
    required bool? isActive,
    @timestampkey DateTime? createdAt,
    @timestampkey DateTime? updatedAt,
    @timestampkey DateTime? deletedAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
