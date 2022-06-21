// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      id: json['id'] as String?,
      organizer: json['organizer'] as String?,
      bazaarId: json['bazaarId'] as String?,
      bazaarName: json['bazaarName'] as String?,
      salesStart: dateFromTimestampValue(json['salesStart']),
      salesEnd: dateFromTimestampValue(json['salesEnd']),
      register: json['register'] as String?,
      exchangeNumber: json['exchangeNumber'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      genre: json['genre'] as String?,
      desc: json['desc'] as String?,
      stock: json['stock'] as int?,
      price: json['price'] as int?,
      picture1Name: json['picture1Name'] as String?,
      picture1URL: json['picture1URL'] as String?,
      picture2Name: json['picture2Name'] as String?,
      picture2URL: json['picture2URL'] as String?,
      picture3Name: json['picture3Name'] as String?,
      picture3URL: json['picture3URL'] as String?,
      expirationFrom: dateFromTimestampValue(json['expirationFrom']),
      expirationTo: dateFromTimestampValue(json['expirationTo']),
      isPublished: json['isPublished'] as bool?,
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizer': instance.organizer,
      'bazaarId': instance.bazaarId,
      'bazaarName': instance.bazaarName,
      'salesStart': timestampFromDateValue(instance.salesStart),
      'salesEnd': timestampFromDateValue(instance.salesEnd),
      'register': instance.register,
      'exchangeNumber': instance.exchangeNumber,
      'code': instance.code,
      'name': instance.name,
      'genre': instance.genre,
      'desc': instance.desc,
      'stock': instance.stock,
      'price': instance.price,
      'picture1Name': instance.picture1Name,
      'picture1URL': instance.picture1URL,
      'picture2Name': instance.picture2Name,
      'picture2URL': instance.picture2URL,
      'picture3Name': instance.picture3Name,
      'picture3URL': instance.picture3URL,
      'expirationFrom': timestampFromDateValue(instance.expirationFrom),
      'expirationTo': timestampFromDateValue(instance.expirationTo),
      'isPublished': instance.isPublished,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };
