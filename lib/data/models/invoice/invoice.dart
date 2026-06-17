import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

@JsonSerializable()
class Invoice {
  @JsonKey(name: 'invoice_id', defaultValue: -1)
  final int invoiceId;
  @JsonKey(name: 'invoice_no', defaultValue: -1)
  final int invoiceNo;
  @JsonKey(name: 'mailbox_no', defaultValue: '')
  final String mailboxNo;
  @JsonKey(name: 'user_name', defaultValue: '')
  final String userName;
  @JsonKey(name: 'status', defaultValue: '')
  final String status;
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;
  @JsonKey(name: 'date_paid', defaultValue: '')
  final String datePaid;
  @JsonKey(name: 'total_invoice', defaultValue: '')
  final dynamic totalInvoice;
  @JsonKey(name: 'total_paid', defaultValue: '')
  final dynamic totalPaid;
  @JsonKey(name: 'is_invoice', defaultValue: 0)
  final int? isInvoice;

  const Invoice({
    required this.invoiceId,
    required this.invoiceNo,
    required this.mailboxNo,
    required this.userName,
    required this.status,
    required this.createdAt,
    required this.datePaid,
    required this.totalInvoice,
    required this.totalPaid,
    this.isInvoice,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return _$InvoiceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}

class AllInvoiceResponse {
  final List<Invoice> invoices;

  AllInvoiceResponse({
    required this.invoices,
  });

  factory AllInvoiceResponse.fromJson(List<dynamic> json) {
    final item = json.map((e) => Invoice.fromJson(e as Map<String, dynamic>));
    return AllInvoiceResponse(
      invoices: item.toList(),
    );
  }
}
