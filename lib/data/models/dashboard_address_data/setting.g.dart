// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      id: (json['id'] as num?)?.toInt() ?? 0,
      siteName: json['site_name'] as String? ?? '',
      preFix: json['pre_fix'] as String? ?? '',
      companyName: json['company_name'] as String? ?? '',
      siteEmail: json['site_email'] as String? ?? '',
      administratorEmail: json['administrator_email'] as String? ?? '',
      siteLogo: json['site_logo'] as String? ?? '',
      fromEmail: json['from_email'] as String? ?? '',
      siteTitle: json['site_title'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      siteFooterText: json['site_footer_text'] as String? ?? '',
      packageShippingAddress1:
          json['package_shipping_address_1'] as String? ?? '',
      packageShippingAddress2:
          json['package_shipping_address_2'] as String? ?? '',
      seaShippingAddress1: json['sea_shipping_address_1'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      zip: json['zip'] as String? ?? '',
      country: json['country'] as String? ?? '',
      localAddress: json['local_address'] as String? ?? '',
      seaShippingAddress2: json['sea_shipping_address_2'] as String? ?? '',
      seaCity: json['sea_city'] as String? ?? '',
      seaState: json['sea_state'] as String? ?? '',
      seaZip: json['sea_zip'] as String? ?? '',
      seaCountry: json['sea_country'] as String? ?? '',
      seaLocalAddress: json['sea_local_address'] as String? ?? '',
      usRate: json['us_rate'] as String? ?? '',
      discount: json['discount'] as String? ?? '',
      rewardPoints: (json['reward_points'] as num?)?.toInt() ?? -1,
      apiToken: json['api_token'] as String? ?? '',
      expressShippingAddress1:
          json['express_shipping_address_1'] as String? ?? '',
      expressShippingAddress2:
          json['express_shipping_address_2'] as String? ?? '',
      expressCity: json['express_city'] as String? ?? '',
      expressState: json['express_state'] as String? ?? '',
      expressZip: json['express_zip'] as String? ?? '',
      expressCountry: json['express_country'] as String? ?? '',
      expressLocalAddress: json['express_local_address'] as String? ?? '',
    );

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'id': instance.id,
      'site_name': instance.siteName,
      'pre_fix': instance.preFix,
      'company_name': instance.companyName,
      'site_email': instance.siteEmail,
      'administrator_email': instance.administratorEmail,
      'site_logo': instance.siteLogo,
      'from_email': instance.fromEmail,
      'site_title': instance.siteTitle,
      'phone': instance.phone,
      'site_footer_text': instance.siteFooterText,
      'package_shipping_address_1': instance.packageShippingAddress1,
      'package_shipping_address_2': instance.packageShippingAddress2,
      'sea_shipping_address_1': instance.seaShippingAddress1,
      'express_shipping_address_1': instance.expressShippingAddress1,
      'express_shipping_address_2': instance.expressShippingAddress2,
      'express_city': instance.expressCity,
      'express_state': instance.expressState,
      'express_zip': instance.expressZip,
      'express_country': instance.expressCountry,
      'express_local_address': instance.expressLocalAddress,
      'city': instance.city,
      'state': instance.state,
      'zip': instance.zip,
      'country': instance.country,
      'local_address': instance.localAddress,
      'sea_shipping_address_2': instance.seaShippingAddress2,
      'sea_city': instance.seaCity,
      'sea_state': instance.seaState,
      'sea_zip': instance.seaZip,
      'sea_country': instance.seaCountry,
      'sea_local_address': instance.seaLocalAddress,
      'us_rate': instance.usRate,
      'discount': instance.discount,
      'reward_points': instance.rewardPoints,
      'api_token': instance.apiToken,
    };
