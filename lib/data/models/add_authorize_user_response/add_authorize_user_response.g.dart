// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_authorize_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAuthorizeUserResponse _$AddAuthorizeUserResponseFromJson(
        Map<String, dynamic> json) =>
    AddAuthorizeUserResponse(
      userId: (json['user_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      proof: json['proof'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddAuthorizeUserResponseToJson(
        AddAuthorizeUserResponse instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'phone': instance.phone,
      'proof': instance.proof,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'id': instance.id,
    };
