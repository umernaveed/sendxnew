// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unpaid_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnpaidInvoice _$UnpaidInvoiceFromJson(Map<String, dynamic> json) =>
    UnpaidInvoice(
      invoiceId: (json['invoice_id'] as num?)?.toInt(),
      invoiceNo: (json['invoice_no'] as num?)?.toInt(),
      mailboxNo: json['mailbox_no'] as String?,
      userName: json['user_name'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      datePaid: json['date_paid'] as String?,
      totalInvoice: json['total_invoice'] as String?,
      totalPaid: json['total_paid'] as String?,
      trackingNo: json['tracking_no'] as String?,
      isToggleOn: json['is_toggle_on'] as bool? ?? false,
    );

Map<String, dynamic> _$UnpaidInvoiceToJson(UnpaidInvoice instance) =>
    <String, dynamic>{
      'invoice_id': instance.invoiceId,
      'invoice_no': instance.invoiceNo,
      'mailbox_no': instance.mailboxNo,
      'user_name': instance.userName,
      'status': instance.status,
      'created_at': instance.createdAt,
      'date_paid': instance.datePaid,
      'total_invoice': instance.totalInvoice,
      'total_paid': instance.totalPaid,
      'tracking_no': instance.trackingNo,
      'is_toggle_on': instance.isToggleOn,
    };
