// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offset_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffsetRequest _$OffsetRequestFromJson(Map<String, dynamic> json) =>
    OffsetRequest(
      offset: json['offset'] as String,
      keyword: json['keyword'] as String? ?? '',
    );

Map<String, dynamic> _$OffsetRequestToJson(OffsetRequest instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'keyword': instance.keyword,
    };
