import 'package:json_annotation/json_annotation.dart';

part 'add_pre_alert_response.g.dart';

@JsonSerializable()
class AddPreAlertResponse {
  @JsonKey(name: 'tracking_no', defaultValue: '')
  final String trackingNo;
  @JsonKey(name: 'user_name', defaultValue: '')
  final String userName;
  @JsonKey(name: 'nick_name', defaultValue: '')
  final String nickName;
  @JsonKey(name: 'merchant', defaultValue: '')
  final String merchant;
  @JsonKey(name: 'mailbox', defaultValue: '')
  final String mailbox;
  @JsonKey(name: 'courier', defaultValue: '')
  final String courier;
  @JsonKey(name: 'supplier_tracking_no', defaultValue: '')
  final String supplierTrackingNo;
  @JsonKey(name: 'weight', defaultValue: '')
  final String weight;
  @JsonKey(name: 'price', defaultValue: '')
  final String price;
  @JsonKey(name: 'manifest_no', defaultValue: '')
  final String manifestNo;
  @JsonKey(name: 'invoice', defaultValue: '')
  final String invoice;
  @JsonKey(name: 'is_temprary_logs', defaultValue: 0)
  final int isTempraryLogs;
  @JsonKey(name: 'status', defaultValue: 0)
  final int status;
  @JsonKey(name: 'status_name', defaultValue: '')
  final String statusName;
  @JsonKey(name: 'item_description', defaultValue: '')
  final String itemDescription;
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;
  @JsonKey(name: 'updated_at', defaultValue: '')
  final String updatedAt;
  @JsonKey(name: 'packeg_id', defaultValue: -1)
  final int packegId;

  const AddPreAlertResponse({
    required this.trackingNo,
    required this.userName,
    required this.nickName,
    required this.merchant,
    required this.mailbox,
    required this.courier,
    required this.supplierTrackingNo,
    required this.weight,
    required this.price,
    required this.manifestNo,
    required this.invoice,
    required this.isTempraryLogs,
    required this.status,
    required this.statusName,
    required this.itemDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.packegId,
  });

  factory AddPreAlertResponse.fromJson(Map<String, dynamic> json) {
    return _$AddPreAlertResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddPreAlertResponseToJson(this);
}
