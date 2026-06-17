import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  @JsonKey(name: 'user_id', defaultValue: -1)
  final int userId;
  @JsonKey(name: 'outlet_id', defaultValue: '')
  final String outletId;
  @JsonKey(name: 'mailbox', defaultValue: '')
  final String mailbox;
  @JsonKey(name: 'first_name', defaultValue: '')
  final String firstName;
  @JsonKey(name: 'last_name', defaultValue: '')
  final String lastName;
  @JsonKey(name: 'user_name', defaultValue: '')
  final String userName;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'password', defaultValue: '')
  final String password;
  @JsonKey(name: 'trn', defaultValue: '')
  final String trn;
  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;
  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  @JsonKey(name: 'mobile', defaultValue: '')
  final String mobile;
  @JsonKey(name: 'tcc_issue_date', defaultValue: '')
  final String tccIssueDate;
  @JsonKey(name: 'tcc_expiry_date', defaultValue: '')
  final String tccExpiryDate;
  @JsonKey(name: 'Business_trn', defaultValue: '')
  final String businessTrn;
  @JsonKey(name: 'tcc1', defaultValue: '')
  final String tcc1;
  @JsonKey(name: 'dob', defaultValue: '')
  final String dob;
  @JsonKey(name: 'address_1', defaultValue: '')
  final String address1;
  @JsonKey(name: 'address_2', defaultValue: '')
  final String address2;
  @JsonKey(name: 'city', defaultValue: '')
  final String city;
  @JsonKey(name: 'state', defaultValue: '')
  final String state;
  @JsonKey(name: 'country', defaultValue: '')
  final String country;
  @JsonKey(name: 'postal_code', defaultValue: '')
  final String postalCode;
  @JsonKey(name: 'currency', defaultValue: '')
  final String currency;
  @JsonKey(name: 'location', defaultValue: '')
  final String location;
  @JsonKey(name: 'user_type', defaultValue: '')
  final String userType;
  @JsonKey(name: 'loyaltynum', defaultValue: '')
  final String loyaltynum;
  @JsonKey(name: 'role_id', defaultValue: -1)
  final int roleId;
  @JsonKey(name: 'is_superadmin', defaultValue: 0)
  final int isSuperadmin;
  @JsonKey(name: 'status', defaultValue: '')
  final String status;
  @JsonKey(name: 'user_access', defaultValue: 1)
  final int userAccess;
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;
  @JsonKey(name: 'updated_at', defaultValue: '')
  final String updatedAt;
  @JsonKey(name: 'address_line2', defaultValue: '')
  final String addressLine2;

  const UserInfo({
    required this.userId,
    required this.outletId,
    required this.mailbox,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    required this.trn,
    required this.phone,
    required this.image,
    required this.mobile,
    required this.tccIssueDate,
    required this.tccExpiryDate,
    required this.businessTrn,
    required this.tcc1,
    required this.dob,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.currency,
    required this.location,
    required this.userType,
    required this.loyaltynum,
    required this.roleId,
    required this.isSuperadmin,
    required this.status,
    required this.userAccess,
    required this.createdAt,
    required this.updatedAt,
    required this.addressLine2,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return _$UserInfoFromJson(json);
  }

  factory UserInfo.empty() {
    return const UserInfo(
      userId: -1,
      outletId: '-1',
      mailbox: '',
      address1: '',
      address2: '',
      businessTrn: '',
      city: '',
      country: '',
      createdAt: '',
      currency: '',
      dob: '',
      email: '',
      firstName: '',
      image: '',
      isSuperadmin: 0,
      lastName: '',
      location: '',
      mobile: '',
      password: '',
      phone: '',
      postalCode: '',
      status: '',
      tcc1: '',
      tccExpiryDate: '',
      tccIssueDate: '',
      trn: '',
      updatedAt: '',
      userName: '',
      userType: '',
      userAccess: 1,
      roleId: -1,
      loyaltynum: '',
      state: '',
      addressLine2: '',
    );
  }

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
