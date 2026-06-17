// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_purchas_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPurchasRequest _$AddPurchasRequestFromJson(Map<String, dynamic> json) =>
    AddPurchasRequest(
      name: json['name'] as String?,
      link: json['link'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AddPurchasRequestToJson(AddPurchasRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'link': instance.link,
      'qty': instance.qty,
      'notes': instance.notes,
    };
