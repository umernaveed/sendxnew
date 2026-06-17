// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_lasco_pay_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleLascoPayRequest _$SingleLascoPayRequestFromJson(
        Map<String, dynamic> json) =>
    SingleLascoPayRequest(
      invoiceIds: json['invoice_ids'] as String?,
      invoiceTotal: json['invoice_total'] as String?,
    );

Map<String, dynamic> _$SingleLascoPayRequestToJson(
        SingleLascoPayRequest instance) =>
    <String, dynamic>{
      'invoice_ids': instance.invoiceIds,
      'invoice_total': instance.invoiceTotal,
    };
