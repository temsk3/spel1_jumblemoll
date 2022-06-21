import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

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
// enum GenreType {
//   goods,
//   foods,
//   others,
// }

// extension GenreTypeExt on GenreType {
//   static final genreTypes = {
//     GenreType.goods: 'Goods',
//     GenreType.foods: 'Foods',
//     GenreType.others: 'Others',
//   };
//   String get genreType => genreTypes[this].toString();
// }

//
@freezed
class Product with _$Product {
  const Product._();

  const factory Product({
    String? id,
    String? organizer,
    String? bazaarId,
    String? bazaarName,
    @timestampkey required DateTime? salesStart,
    @timestampkey required DateTime? salesEnd,
    String? register,
    int? exchangeNumber, //不要
    String? code,
    required String? name,
    required String? genre,
    required String? desc,
    required int? stock,
    required int? price,
    String? picture1Name,
    String? picture1URL,
    String? picture2Name,
    String? picture2URL,
    String? picture3Name,
    String? picture3URL,
    @timestampkey required DateTime? expirationFrom,
    @timestampkey required DateTime? expirationTo,
    required bool? isPublished,
    @timestampkey DateTime? createdAt,
    @timestampkey DateTime? updatedAt,
    @timestampkey DateTime? deletedAt,
  }) = _Product;

  factory Product.empty() => const Product(
        organizer: '',
        salesStart: null,
        salesEnd: null,
        register: '',
        name: '',
        genre: 'Goods',
        desc: '',
        stock: 0,
        price: 0,
        picture1Name: '',
        picture1URL: '',
        picture2Name: '',
        picture2URL: '',
        picture3Name: '',
        picture3URL: '',
        expirationFrom: null,
        expirationTo: null,
        isPublished: true,
      );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
