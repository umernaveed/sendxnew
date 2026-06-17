// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_address_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardAddressData _$DashboardAddressDataFromJson(
        Map<String, dynamic> json) =>
    DashboardAddressData(
      setting: json['setting'] == null
          ? Setting.dashboardAddressSetting()
          : Setting.fromJson(json['setting'] as Map<String, dynamic>),
      userInfo: json['user_info'] == null
          ? UserInfo.empty()
          : UserInfo.fromJson(json['user_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardAddressDataToJson(
        DashboardAddressData instance) =>
    <String, dynamic>{
      'setting': instance.setting,
      'user_info': instance.userInfo,
    };
