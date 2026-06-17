// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      siteName: json['site_name'] as String?,
      baseUrl: json['base_url'] as String?,
      appLogo: json['app_logo'] as String?,
      siteTitle: json['site_title'] as String?,
      btnColor: json['btn_color'] as String?,
      textColor: json['text_color'] as String?,
      appVersion: json['app_version'] as String?,
    );

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'site_name': instance.siteName,
      'base_url': instance.baseUrl,
      'app_logo': instance.appLogo,
      'site_title': instance.siteTitle,
      'btn_color': instance.btnColor,
      'text_color': instance.textColor,
      'app_version': instance.appVersion,
    };
