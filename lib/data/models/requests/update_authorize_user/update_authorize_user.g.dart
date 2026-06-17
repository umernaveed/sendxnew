// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_authorize_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAuthorizeUser _$UpdateAuthorizeUserFromJson(Map<String, dynamic> json) =>
    UpdateAuthorizeUser(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      proof: json['proof'] as String,
    );

Map<String, dynamic> _$UpdateAuthorizeUserToJson(
        UpdateAuthorizeUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'proof': instance.proof,
    };
