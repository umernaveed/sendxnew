// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lasco_mass_pay_invoice_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LascoMassPayInvoiceRequest _$LascoMassPayInvoiceRequestFromJson(
        Map<String, dynamic> json) =>
    LascoMassPayInvoiceRequest(
      invoiceIds: json['invoice_ids'] as String?,
      packageIds: json['package_ids'] as String?,
      invoiceTotal: json['invoice_total'] as String?,
    );

Map<String, dynamic> _$LascoMassPayInvoiceRequestToJson(
        LascoMassPayInvoiceRequest instance) =>
    <String, dynamic>{
      'invoice_ids': instance.invoiceIds,
      'package_ids': instance.packageIds,
      'invoice_total': instance.invoiceTotal,
    };
