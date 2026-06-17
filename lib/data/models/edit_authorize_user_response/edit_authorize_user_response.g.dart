// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_authorize_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditAuthorizeUserResponse _$EditAuthorizeUserResponseFromJson(
        Map<String, dynamic> json) =>
    EditAuthorizeUserResponse(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      proof: json['proof'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$EditAuthorizeUserResponseToJson(
        EditAuthorizeUserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'phone': instance.phone,
      'proof': instance.proof,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
