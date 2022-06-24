// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supporter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Supporter _$$_SupporterFromJson(Map<String, dynamic> json) => _$_Supporter(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
      eventId: json['eventId'] as String?,
    );

Map<String, dynamic> _$$_SupporterToJson(_$_Supporter instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'isActive': instance.isActive,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
      'eventId': instance.eventId,
    };
