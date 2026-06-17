// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppMeta _$AppMetaFromJson(Map<String, dynamic> json) => AppMeta(
      setting: json['setting'] == null
          ? null
          : Setting.fromJson(json['setting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppMetaToJson(AppMeta instance) => <String, dynamic>{
      'setting': instance.setting,
    };
