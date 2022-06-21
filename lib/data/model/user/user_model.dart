// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// import '../../../utils/verification_status.dart';

// part 'user_model.freezed.dart';
// part 'user_model.g.dart';

// // // firestore から受け取った Timestamp型を DateTime型に変換するためにJsonKeyを作成 @timestamp DateTime
// DateTime? dateFromTimestampValue(dynamic value) =>
//     value != null ? (value as Timestamp).toDate() : null;

// Timestamp? timestampFromDateValue(dynamic value) =>
//     value is DateTime ? Timestamp.fromDate(value) : null;

// const timestampkey = JsonKey(
//   fromJson: dateFromTimestampValue,
//   toJson: timestampFromDateValue,
// );

// //
// @freezed
// class User with _$User {
//   const User._();

//   const factory User({
//     String? id,
//     String? displayName,
//     String? email,
//     String? customerId,
//     String? accountId,
//     String? sourceId,
//     Status? status,
//     bool? chargesEnabled,
//   }) = _User;

//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
// }
import '../../../utils/verification_status.dart';

class User {
  String? id;
  String? displayName;
  String? email;
  String? customerId;
  String? accountId;
  String? sourceId;
  Status? status;
  bool? chargesEnabled;

  User({
    this.id,
    this.displayName,
    this.email,
    this.customerId,
    this.accountId,
    this.sourceId,
    this.status,
    this.chargesEnabled,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    email = json['email'];
    customerId = json['customerId'];
    accountId = json['accountId'];
    sourceId = json['sourceId'];
    status = StatusExtension.parseUserStatus(json['status'] as String);
    chargesEnabled = json['chargesEnabled'];
  }
}
