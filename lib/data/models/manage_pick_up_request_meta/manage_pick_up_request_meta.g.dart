// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_pick_up_request_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagePickUpRequestMeta _$ManagePickUpRequestMetaFromJson(
        Map<String, dynamic> json) =>
    ManagePickUpRequestMeta(
      areas: (json['areas'] as List<dynamic>?)
          ?.map((e) => Area.fromJson(e as Map<String, dynamic>))
          .toList(),
      days: (json['days'] as List<dynamic>?)
          ?.map((e) => Day.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManagePickUpRequestMetaToJson(
        ManagePickUpRequestMeta instance) =>
    <String, dynamic>{
      'areas': instance.areas,
      'days': instance.days,
    };
