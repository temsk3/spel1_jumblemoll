// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Order _$$_OrderFromJson(Map<String, dynamic> json) => _$_Order(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      organizer: json['organizer'] as String?,
      bazaarId: json['bazaarId'] as String?,
      bazaarName: json['bazaarName'] as String?,
      exchangeNumber: json['exchangeNumber'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      desc: json['desc'] as String?,
      price: json['price'] as int?,
      numberOfUse: json['numberOfUse'] as int?,
      quantity: json['quantity'] as int?,
      sum: json['sum'] as int?,
      picture1URL: json['picture1URL'] as String?,
      picture2URL: json['picture2URL'] as String?,
      picture3URL: json['picture3URL'] as String?,
      expirationFrom: dateFromTimestampValue(json['expirationFrom']),
      expirationTo: dateFromTimestampValue(json['expirationTo']),
      isActive: json['isActive'] as bool?,
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$$_OrderToJson(_$_Order instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'organizer': instance.organizer,
      'bazaarId': instance.bazaarId,
      'bazaarName': instance.bazaarName,
      'exchangeNumber': instance.exchangeNumber,
      'code': instance.code,
      'name': instance.name,
      'desc': instance.desc,
      'price': instance.price,
      'numberOfUse': instance.numberOfUse,
      'quantity': instance.quantity,
      'sum': instance.sum,
      'picture1URL': instance.picture1URL,
      'picture2URL': instance.picture2URL,
      'picture3URL': instance.picture3URL,
      'expirationFrom': timestampFromDateValue(instance.expirationFrom),
      'expirationTo': timestampFromDateValue(instance.expirationTo),
      'isActive': instance.isActive,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };
