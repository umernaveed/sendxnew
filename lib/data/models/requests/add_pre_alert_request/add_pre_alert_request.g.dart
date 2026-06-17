// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_pre_alert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPreAlertRequest _$AddPreAlertRequestFromJson(Map<String, dynamic> json) =>
    AddPreAlertRequest(
      nickName: json['nick_name'] as String,
      merchant: json['merchant'] as String,
      courier: json['courier'] as String,
      supplierTrackingNo: json['supplier_tracking_no'] as String,
      weight: json['weight'] as String,
      price: json['price'] as String,
      itemDescription: json['item_description'] as String,
    );

Map<String, dynamic> _$AddPreAlertRequestToJson(AddPreAlertRequest instance) =>
    <String, dynamic>{
      'nick_name': instance.nickName,
      'merchant': instance.merchant,
      'courier': instance.courier,
      'supplier_tracking_no': instance.supplierTrackingNo,
      'weight': instance.weight,
      'price': instance.price,
      'item_description': instance.itemDescription,
    };
