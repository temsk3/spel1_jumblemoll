import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

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
class Cart with _$Cart {
  const Cart._();

  const factory Cart({
    String? id,
    String? userRef,
    String? eventRef,
    String? eventName,
    required bool? isActive,
    @timestampkey DateTime? createdAt,
    @timestampkey DateTime? updatedAt,
    @timestampkey DateTime? deletedAt,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
