// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      id: (json['id'] as num).toInt(),
      areaId: (json['area_id'] as num).toInt(),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      numberOfRequests: (json['num_of_requests'] as num).toInt(),
      availableCount: (json['available_count'] as num).toInt(),
      dayId: (json['day_id'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'id': instance.id,
      'area_id': instance.areaId,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'num_of_requests': instance.numberOfRequests,
      'available_count': instance.availableCount,
      'day_id': instance.dayId,
      'type': instance.type,
    };
