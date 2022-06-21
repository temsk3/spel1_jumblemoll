import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bazaar_model.freezed.dart';
part 'bazaar_model.g.dart';

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
class Bazaar with _$Bazaar {
  const Bazaar._();

  const factory Bazaar({
    String? id,
    required String? organizer,
    required String? name,
    required String? message,
    @timestampkey required DateTime? salesStart,
    @timestampkey required DateTime? salesEnd,
    @timestampkey required DateTime? eventFrom,
    @timestampkey required DateTime? eventTo,
    required String? place,
    String? pictureName,
    String? pictureURL,
    @timestampkey DateTime? createdAt,
    @timestampkey DateTime? updatedAt,
    @timestampkey DateTime? deletedAt,
    String? eventId,
  }) = _Bazaar;

  factory Bazaar.empty() => const Bazaar(
        organizer: '',
        name: '',
        message: '',
        salesStart: null,
        salesEnd: null,
        eventFrom: null,
        eventTo: null,
        place: '',
      );

  factory Bazaar.fromJson(Map<String, dynamic> json) => _$BazaarFromJson(json);
}

// abstract class Bazaar implements _$Bazaar {
//   const factory Bazaar({
//     String? id,
//     required String? organizer,
//     required String? name,
//   }) = _Bazaar;

//   factory Bazaar.fromJson(Map<String, dynamic> json) => _$BazaarFromJson(json);

//   factory Bazaar.fromDocument(doc) {
//     final data = doc.data()! as Map<String, dynamic>;
//     return Bazaar.fromJson(data).copyWith(id: doc.id);
//   }
// }
// abstract class Bazaar implements _$Bazaar {
// //   const Bazaar._();

//   const factory Bazaar({
//     String? id,
//     required String? organizer,
//     required String? name,
//   }) = _Bazaar;

//   factory Bazaar.empty() => const Bazaar(
//         id: '',
//         organizer: '',
//         name: '',
//       );

//   factory Bazaar.fromJson(Map<String, dynamic> json) => _$BazaarFromJson(json);

//   factory Bazaar.fromDocument(DocumentSnapshot doc) {
//     final data = doc.data()! as Map<String, dynamic>;
//     return Bazaar.fromJson(data).copyWith(id: doc.id);
//   }
//   Map<String, dynamic> toDocument() => toJson()..remove('id');
// }
