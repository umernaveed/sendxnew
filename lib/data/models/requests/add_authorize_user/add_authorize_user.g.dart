// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_authorize_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAuthorizeUser _$AddAuthorizeUserFromJson(Map<String, dynamic> json) =>
    AddAuthorizeUser(
      name: json['name'] as String,
      phone: json['phone'] as String,
      proof: json['proof'] as String,
    );

Map<String, dynamic> _$AddAuthorizeUserToJson(AddAuthorizeUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'proof': instance.proof,
    };
