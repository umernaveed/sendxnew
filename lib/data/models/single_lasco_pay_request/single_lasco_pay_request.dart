import 'package:json_annotation/json_annotation.dart';

part 'single_lasco_pay_request.g.dart';

@JsonSerializable()
class SingleLascoPayRequest {
  @JsonKey(name: 'invoice_ids')
  final String? invoiceIds;
  @JsonKey(name: 'invoice_total')
  final String? invoiceTotal;

  const SingleLascoPayRequest({this.invoiceIds, this.invoiceTotal});

  factory SingleLascoPayRequest.fromJson(Map<String, dynamic> json) {
    return _$SingleLascoPayRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SingleLascoPayRequestToJson(this);
}
