// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_out_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogOutRequest _$LogOutRequestFromJson(Map<String, dynamic> json) =>
    LogOutRequest(
      loginToken: json['login_token'] as String,
    );

Map<String, dynamic> _$LogOutRequestToJson(LogOutRequest instance) =>
    <String, dynamic>{
      'login_token': instance.loginToken,
    };
