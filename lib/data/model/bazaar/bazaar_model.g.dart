// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bazaar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bazaar _$$_BazaarFromJson(Map<String, dynamic> json) => _$_Bazaar(
      id: json['id'] as String?,
      organizer: json['organizer'] as String?,
      name: json['name'] as String?,
      message: json['message'] as String?,
      salesStart: dateFromTimestampValue(json['salesStart']),
      salesEnd: dateFromTimestampValue(json['salesEnd']),
      eventFrom: dateFromTimestampValue(json['eventFrom']),
      eventTo: dateFromTimestampValue(json['eventTo']),
      place: json['place'] as String?,
      pictureName: json['pictureName'] as String?,
      pictureURL: json['pictureURL'] as String?,
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
      eventId: json['eventId'] as String?,
    );

Map<String, dynamic> _$$_BazaarToJson(_$_Bazaar instance) => <String, dynamic>{
      'id': instance.id,
      'organizer': instance.organizer,
      'name': instance.name,
      'message': instance.message,
      'salesStart': timestampFromDateValue(instance.salesStart),
      'salesEnd': timestampFromDateValue(instance.salesEnd),
      'eventFrom': timestampFromDateValue(instance.eventFrom),
      'eventTo': timestampFromDateValue(instance.eventTo),
      'place': instance.place,
      'pictureName': instance.pictureName,
      'pictureURL': instance.pictureURL,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
      'eventId': instance.eventId,
    };
