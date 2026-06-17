import 'package:json_annotation/json_annotation.dart';

part 'lasco_mass_pay_invoice_request.g.dart';

@JsonSerializable()
class LascoMassPayInvoiceRequest {
  @JsonKey(name: 'invoice_ids')
  final String? invoiceIds;
  @JsonKey(name: 'package_ids')
  final String? packageIds;
  @JsonKey(name: 'invoice_total')
  final String? invoiceTotal;

  const LascoMassPayInvoiceRequest({
    this.invoiceIds,
    this.packageIds,
    this.invoiceTotal,
  });

  factory LascoMassPayInvoiceRequest.fromJson(Map<String, dynamic> json) {
    return _$LascoMassPayInvoiceRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LascoMassPayInvoiceRequestToJson(this);
}
