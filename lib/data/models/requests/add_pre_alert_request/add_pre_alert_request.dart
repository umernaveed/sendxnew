import 'package:json_annotation/json_annotation.dart';

part 'add_pre_alert_request.g.dart';

@JsonSerializable()
class AddPreAlertRequest {
  @JsonKey(name: 'nick_name')
  final String nickName;
  @JsonKey(name: 'merchant')
  final String merchant;
  @JsonKey(name: 'courier')
  final String courier;
  @JsonKey(name: 'supplier_tracking_no')
  final String supplierTrackingNo;
  @JsonKey(name: 'weight')
  final String weight;
  @JsonKey(name: 'price')
  final String price;
  @JsonKey(name: 'item_description')
  final String itemDescription;

  const AddPreAlertRequest({
    required this.nickName,
    required this.merchant,
    required this.courier,
    required this.supplierTrackingNo,
    required this.weight,
    required this.price,
    required this.itemDescription,
  });

  factory AddPreAlertRequest.fromJson(Map<String, dynamic> json) {
    return _$AddPreAlertRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddPreAlertRequestToJson(this);
}
