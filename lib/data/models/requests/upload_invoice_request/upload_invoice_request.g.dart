// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_invoice_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadInvoiceRequest _$UploadInvoiceRequestFromJson(
        Map<String, dynamic> json) =>
    UploadInvoiceRequest(
      packegId: (json['packeg_id'] as num).toInt(),
    );

Map<String, dynamic> _$UploadInvoiceRequestToJson(
        UploadInvoiceRequest instance) =>
    <String, dynamic>{
      'packeg_id': instance.packegId,
    };
