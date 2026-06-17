import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart';

@JsonSerializable()
class EditProfileRequest {
  @JsonKey(name: 'user_type')
  final String userType;
  @JsonKey(name: 'outlet_id')
  final String outletId;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String email;
  final String phone;
  final String trn;
  final String mobile;
  @JsonKey(name: 'tcc_issue_date')
  final String tccIssueDate;
  @JsonKey(name: 'tcc_expiry_date')
  final String tccExpiryDate;
  @JsonKey(name: 'Business_trn')
  final String businessTrn;
  @JsonKey(name: 'address_1')
  final String address1;
  @JsonKey(name: 'address_2')
  final String address2;
  final String city;
  final String state;
  final String country;

  const EditProfileRequest({
    required this.userType,
    required this.outletId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.trn,
    required this.mobile,
    required this.tccIssueDate,
    required this.tccExpiryDate,
    required this.businessTrn,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.country,
  });

  @override
  String toString() {
    return 'EditProfileRequest(userType: $userType, outletId: $outletId, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, trn: $trn, mobile: $mobile, tccIssueDate: $tccIssueDate, tccExpiryDate: $tccExpiryDate, businessTrn: $businessTrn, address1: $address1, address2: $address2, city: $city, state: $state, country: $country)';
  }

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) {
    return _$EditProfileRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);

  EditProfileRequest copyWith({
    String? userType,
    String? outletId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? trn,
    String? mobile,
    String? tccIssueDate,
    String? tccExpiryDate,
    String? businessTrn,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? country,
  }) {
    return EditProfileRequest(
      userType: userType ?? this.userType,
      outletId: outletId ?? this.outletId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      trn: trn ?? this.trn,
      mobile: mobile ?? this.mobile,
      tccIssueDate: tccIssueDate ?? this.tccIssueDate,
      tccExpiryDate: tccExpiryDate ?? this.tccExpiryDate,
      businessTrn: businessTrn ?? this.businessTrn,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
    );
  }
}
