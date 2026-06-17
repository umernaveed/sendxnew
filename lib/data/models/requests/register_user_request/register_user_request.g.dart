// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterUserRequest _$RegisterUserRequestFromJson(Map<String, dynamic> json) =>
    RegisterUserRequest(
      outletId: json['outlet_id'] as String,
      userType: json['user_type'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      address1: json['address_1'] as String,
      deviceType: json['device_type'] as String,
      deviceToken: json['device_token'] as String,
      appVersion: json['app_version'] as String,
      timeZone: json['time_zone'] as String,
      confirmEmail: json['confirm_email'] as String,
      refferalCode: json['refferal_code'] as String,
      managerId: json['manager_id'] as String,
    );

Map<String, dynamic> _$RegisterUserRequestToJson(
        RegisterUserRequest instance) =>
    <String, dynamic>{
      'outlet_id': instance.outletId,
      'manager_id': instance.managerId,
      'user_type': instance.userType,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'address_1': instance.address1,
      'device_type': instance.deviceType,
      'device_token': instance.deviceToken,
      'app_version': instance.appVersion,
      'time_zone': instance.timeZone,
      'confirm_email': instance.confirmEmail,
      'refferal_code': instance.refferalCode,
    };
