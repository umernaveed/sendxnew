// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      invoiceId: (json['invoice_id'] as num?)?.toInt() ?? -1,
      invoiceNo: (json['invoice_no'] as num?)?.toInt() ?? -1,
      mailboxNo: json['mailbox_no'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      status: json['status'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      datePaid: json['date_paid'] as String? ?? '',
      totalInvoice: json['total_invoice'] ?? '',
      totalPaid: json['total_paid'] ?? '',
      isInvoice: (json['is_invoice'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'invoice_id': instance.invoiceId,
      'invoice_no': instance.invoiceNo,
      'mailbox_no': instance.mailboxNo,
      'user_name': instance.userName,
      'status': instance.status,
      'created_at': instance.createdAt,
      'date_paid': instance.datePaid,
      'total_invoice': instance.totalInvoice,
      'total_paid': instance.totalPaid,
      'is_invoice': instance.isInvoice,
    };
