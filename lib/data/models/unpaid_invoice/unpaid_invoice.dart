import 'package:json_annotation/json_annotation.dart';

part 'unpaid_invoice.g.dart';

@JsonSerializable()
class UnpaidInvoice {
  @JsonKey(name: 'invoice_id')
  final int? invoiceId;
  @JsonKey(name: 'invoice_no')
  final int? invoiceNo;
  @JsonKey(name: 'mailbox_no')
  final String? mailboxNo;
  @JsonKey(name: 'user_name')
  final String? userName;
  final String? status;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'date_paid')
  final String? datePaid;
  @JsonKey(name: 'total_invoice')
  final String? totalInvoice;
  @JsonKey(name: 'total_paid')
  final String? totalPaid;
  @JsonKey(name: 'tracking_no')
  final String? trackingNo;

  /// to handle the the toggle state
  @JsonKey(name: 'is_toggle_on', defaultValue: false)
  bool isToggleOn;

  UnpaidInvoice({
    this.invoiceId,
    this.invoiceNo,
    this.mailboxNo,
    this.userName,
    this.status,
    this.createdAt,
    this.datePaid,
    this.totalInvoice,
    this.totalPaid,
    this.trackingNo,
    this.isToggleOn = false,
  });

  factory UnpaidInvoice.fromJson(Map<String, dynamic> json) {
    return _$UnpaidInvoiceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UnpaidInvoiceToJson(this);
}
