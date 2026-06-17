// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      id: (json['id'] as num?)?.toInt(),
      dayId: json['day_id'] as String?,
      day: json['day'] as String?,
    );

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'id': instance.id,
      'day_id': instance.dayId,
      'day': instance.day,
    };
