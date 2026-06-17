import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';

@JsonSerializable()
class UpdateUserRequest {
  @JsonKey(name: 'user_type')
  final String userType;
  @JsonKey(name: 'outlet_id')
  final String outletId;
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

  const UpdateUserRequest({
    required this.userType,
    required this.outletId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    // required this.trn,
    // required this.mobile,
    // required this.tccIssueDate,
    // required this.tccExpiryDate,
    // required this.businessTrn,
    required this.address1,
    // required this.address2,
    // required this.city,
    // required this.state,
    // required this.country,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateUserRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);

  UpdateUserRequest copyWith({
    String? userType,
    String? outletId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? address1,
  }) {
    return UpdateUserRequest(
      userType: userType ?? this.userType,
      outletId: outletId ?? this.outletId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address1: address1 ?? this.address1,
    );
  }
}
