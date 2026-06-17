// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_purchase_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePurchaseRequest _$UpdatePurchaseRequestFromJson(
        Map<String, dynamic> json) =>
    UpdatePurchaseRequest(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      link: json['link'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$UpdatePurchaseRequestToJson(
        UpdatePurchaseRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'link': instance.link,
      'qty': instance.qty,
      'notes': instance.notes,
    };
