// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Area _$AreaFromJson(Map<String, dynamic> json) => Area(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      cost: json['cost'] as String?,
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      timeSlots: (json['timeslots'] as List<dynamic>?)
          ?.map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cost': instance.cost,
      'status': instance.status,
      'created_at': instance.createdAt,
      'timeslots': instance.timeSlots,
    };
