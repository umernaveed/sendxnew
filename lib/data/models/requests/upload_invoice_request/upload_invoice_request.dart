import 'package:json_annotation/json_annotation.dart';

part 'upload_invoice_request.g.dart';

@JsonSerializable()
class UploadInvoiceRequest {
  @JsonKey(name: 'packeg_id')
  final int packegId;

  const UploadInvoiceRequest({required this.packegId});

  factory UploadInvoiceRequest.fromJson(Map<String, dynamic> json) {
    return _$UploadInvoiceRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UploadInvoiceRequestToJson(this);
}
