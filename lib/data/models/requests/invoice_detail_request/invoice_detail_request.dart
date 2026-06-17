import 'package:json_annotation/json_annotation.dart';

part 'invoice_detail_request.g.dart';

@JsonSerializable()
class InvoiceDetailRequest {
  @JsonKey(name: 'invoice_no')
  final String invoiceNo;

  const InvoiceDetailRequest({required this.invoiceNo});

  factory InvoiceDetailRequest.fromJson(Map<String, dynamic> json) {
    return _$InvoiceDetailRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvoiceDetailRequestToJson(this);
}
