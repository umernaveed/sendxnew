// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_pre_alert_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPreAlertResponse _$AddPreAlertResponseFromJson(Map<String, dynamic> json) =>
    AddPreAlertResponse(
      trackingNo: json['tracking_no'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      nickName: json['nick_name'] as String? ?? '',
      merchant: json['merchant'] as String? ?? '',
      mailbox: json['mailbox'] as String? ?? '',
      courier: json['courier'] as String? ?? '',
      supplierTrackingNo: json['supplier_tracking_no'] as String? ?? '',
      weight: json['weight'] as String? ?? '',
      price: json['price'] as String? ?? '',
      manifestNo: json['manifest_no'] as String? ?? '',
      invoice: json['invoice'] as String? ?? '',
      isTempraryLogs: (json['is_temprary_logs'] as num?)?.toInt() ?? 0,
      status: (json['status'] as num?)?.toInt() ?? 0,
      statusName: json['status_name'] as String? ?? '',
      itemDescription: json['item_description'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      packegId: (json['packeg_id'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$AddPreAlertResponseToJson(
        AddPreAlertResponse instance) =>
    <String, dynamic>{
      'tracking_no': instance.trackingNo,
      'user_name': instance.userName,
      'nick_name': instance.nickName,
      'merchant': instance.merchant,
      'mailbox': instance.mailbox,
      'courier': instance.courier,
      'supplier_tracking_no': instance.supplierTrackingNo,
      'weight': instance.weight,
      'price': instance.price,
      'manifest_no': instance.manifestNo,
      'invoice': instance.invoice,
      'is_temprary_logs': instance.isTempraryLogs,
      'status': instance.status,
      'status_name': instance.statusName,
      'item_description': instance.itemDescription,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'packeg_id': instance.packegId,
    };
