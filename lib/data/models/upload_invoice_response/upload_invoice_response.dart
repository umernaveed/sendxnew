import 'package:json_annotation/json_annotation.dart';

part 'upload_invoice_response.g.dart';

@JsonSerializable()
class UploadInvoiceResponse {
  @JsonKey(name: 'invoice', defaultValue: '')
  final String invoice;

  const UploadInvoiceResponse({required this.invoice});

  factory UploadInvoiceResponse.fromJson(Map<String, dynamic> json) {
    return _$UploadInvoiceResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UploadInvoiceResponseToJson(this);
}
