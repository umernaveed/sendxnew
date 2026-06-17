import 'package:json_annotation/json_annotation.dart';

part 'register_user_request.g.dart';

@JsonSerializable()
class RegisterUserRequest {
  @JsonKey(name: 'outlet_id')
  final String outletId;
  @JsonKey(name: 'manager_id')
  final String managerId;

  @JsonKey(name: 'user_type')
  final String userType;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'phone')
  final String phone;
  // @JsonKey(name: 'trn')
  // final String trn;
  @JsonKey(name: 'password')
  final String password;
  // @JsonKey(name: 'mobile')
  // final String mobile;
  // @JsonKey(name: 'tcc_issue_date')
  // final String tccIssueDate;
  // @JsonKey(name: 'tcc_expiry_date')
  // final String tccExpiryDate;
  // @JsonKey(name: 'Business_trn')
  // final String businessTrn;
  @JsonKey(name: 'address_1')
  final String address1;
  // @JsonKey(name: 'address_2')
  // final String address2;
  // @JsonKey(name: 'city')
  // final String city;
  // @JsonKey(name: 'state')
  // final String state;
  // @JsonKey(name: 'country')
  // final String country;
  @JsonKey(name: 'device_type')
  final String deviceType;
  @JsonKey(name: 'device_token')
  final String deviceToken;
  @JsonKey(name: 'app_version')
  final String appVersion;
  @JsonKey(name: 'time_zone')
  final String timeZone;
  @JsonKey(name: 'confirm_email')
  final String confirmEmail;
  @JsonKey(name: 'refferal_code')
  final String refferalCode;

  const RegisterUserRequest({
    required this.outletId,
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    // required this.trn,
    required this.password,
    // required this.mobile,
    // required this.tccIssueDate,
    // required this.tccExpiryDate,
    // required this.businessTrn,
    required this.address1,
    // required this.address2,
    // required this.city,
    // required this.state,
    // required this.country,
    required this.deviceType,
    required this.deviceToken,
    required this.appVersion,
    required this.timeZone,
    required this.confirmEmail,
    // required this.currency,
    required this.refferalCode,
    required this.managerId,
  });

  factory RegisterUserRequest.fromJson(Map<String, dynamic> json) {
    return _$RegisterUserRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegisterUserRequestToJson(this);
}
