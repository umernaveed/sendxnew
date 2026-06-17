// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      deviceType: json['device_type'] as String,
      deviceToken: json['device_token'] as String,
      appVersion: json['app_version'] as String,
      timeZone: json['time_zone'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'device_type': instance.deviceType,
      'device_token': instance.deviceToken,
      'app_version': instance.appVersion,
      'time_zone': instance.timeZone,
    };
