import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class User extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'user_id', defaultValue: -1)
  final int userId;

  @HiveField(1)
  @JsonKey(name: 'outlet_id', defaultValue: '-1')
  final String outletId;

  @HiveField(2)
  @JsonKey(name: 'mailbox', defaultValue: '')
  final String mailbox;

  @HiveField(3)
  @JsonKey(name: 'first_name', defaultValue: '')
  final String firstName;

  @HiveField(4)
  @JsonKey(name: 'last_name', defaultValue: '')
  final String lastName;

  @HiveField(5)
  @JsonKey(name: 'user_name', defaultValue: '')
  final String userName;

  @HiveField(6)
  @JsonKey(name: 'email', defaultValue: '')
  final String email;

  @HiveField(7)
  @JsonKey(name: 'password', defaultValue: '')
  final String password;

  @HiveField(8)
  @JsonKey(name: 'trn', defaultValue: '')
  final String trn;

  @HiveField(9)
  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;

  @HiveField(10)
  @JsonKey(name: 'image', defaultValue: '')
  final String image;

  @HiveField(11)
  @JsonKey(name: 'mobile', defaultValue: '')
  final String mobile;

  @HiveField(12)
  @JsonKey(name: 'tcc_issue_date', defaultValue: '')
  final String tccIssueDate;

  @HiveField(13)
  @JsonKey(name: 'tcc_expiry_date', defaultValue: '')
  final String tccExpiryDate;

  @HiveField(14)
  @JsonKey(name: 'Business_trn', defaultValue: '')
  final String businessTrn;

  @HiveField(15)
  @JsonKey(name: 'tcc1', defaultValue: '')
  final String tcc1;

  @HiveField(16)
  @JsonKey(name: 'dob', defaultValue: '')
  final String dob;

  @HiveField(17)
  @JsonKey(name: 'address_1', defaultValue: '')
  final String address1;

  @HiveField(18)
  @JsonKey(name: 'address_2', defaultValue: '')
  final String address2;

  @HiveField(19)
  @JsonKey(name: 'city', defaultValue: '')
  final String city;

  @HiveField(20)
  @JsonKey(name: 'state', defaultValue: '')
  final String state;

  @HiveField(21)
  @JsonKey(name: 'country', defaultValue: '')
  final String country;

  @HiveField(22)
  @JsonKey(name: 'postal_code', defaultValue: '')
  final String postalCode;

  @HiveField(23)
  @JsonKey(name: 'currency', defaultValue: 'JMD')
  final String currency;

  @HiveField(24)
  @JsonKey(name: 'location', defaultValue: '')
  final String location;

  @HiveField(25)
  @JsonKey(name: 'user_type', defaultValue: 'Regular User')
  final String userType;

  @HiveField(26)
  @JsonKey(name: 'loyaltynum', defaultValue: '')
  final String loyaltynum;

  @HiveField(27)
  @JsonKey(name: 'role_id', defaultValue: -1)
  final int roleId;

  @HiveField(28)
  @JsonKey(name: 'is_superadmin', defaultValue: 0)
  final int isSuperadmin;

  @HiveField(29)
  @JsonKey(name: 'status', defaultValue: '')
  final String status;
  @HiveField(30)
  @JsonKey(name: 'user_access', defaultValue: 1)
  final int userAccess;

  @HiveField(31)
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;
  @HiveField(32)
  @JsonKey(name: 'updated_at', defaultValue: '')
  final String updatedAt;

  @HiveField(33)
  @JsonKey(name: 'accessToken', defaultValue: '')
  final String accessToken;
  @HiveField(34)
  @JsonKey(name: 'loginToken', defaultValue: '')
  final String loginToken;

  String get completeName => '$firstName $lastName';

  User({
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
    required this.accessToken,
    required this.loginToken,
  });

  factory User.empty() {
    return User(
      userId: -1,
      outletId: '-1',
      mailbox: '',
      accessToken: '',
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
      loginToken: '',
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
    );
  }

  @override
  String toString() {
    return 'User(userId: $userId, outletId: $outletId, mailbox: $mailbox, firstName: $firstName, lastName: $lastName, userName: $userName, email: $email, password: $password, trn: $trn, phone: $phone, image: $image, mobile: $mobile, tccIssueDate: $tccIssueDate, tccExpiryDate: $tccExpiryDate, businessTrn: $businessTrn, tcc1: $tcc1, dob: $dob, address1: $address1, address2: $address2, city: $city, state: $state, country: $country, postalCode: $postalCode, currency: $currency, location: $location, userType: $userType, loyaltynum: $loyaltynum, roleId: $roleId, isSuperadmin: $isSuperadmin, status: $status, userAccess: $userAccess, createdAt: $createdAt, updatedAt: $updatedAt, accessToken: $accessToken, loginToken: $loginToken)';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? userId,
    String? outletId,
    String? mailbox,
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? password,
    String? trn,
    String? phone,
    String? image,
    String? mobile,
    String? tccIssueDate,
    String? tccExpiryDate,
    String? businessTrn,
    String? tcc1,
    String? dob,
    dynamic address1,
    dynamic address2,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? currency,
    String? location,
    String? userType,
    String? loyaltynum,
    int? roleId,
    int? isSuperadmin,
    String? status,
    int? userAccess,
    String? createdAt,
    String? updatedAt,
    String? accessToken,
    String? loginToken,
  }) {
    return User(
      userId: userId ?? this.userId,
      outletId: outletId ?? this.outletId,
      mailbox: mailbox ?? this.mailbox,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      trn: trn ?? this.trn,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      mobile: mobile ?? this.mobile,
      tccIssueDate: tccIssueDate ?? this.tccIssueDate,
      tccExpiryDate: tccExpiryDate ?? this.tccExpiryDate,
      businessTrn: businessTrn ?? this.businessTrn,
      tcc1: tcc1 ?? this.tcc1,
      dob: dob ?? this.dob,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      currency: currency ?? this.currency,
      location: location ?? this.location,
      userType: userType ?? this.userType,
      loyaltynum: loyaltynum ?? this.loyaltynum,
      roleId: roleId ?? this.roleId,
      isSuperadmin: isSuperadmin ?? this.isSuperadmin,
      status: status ?? this.status,
      userAccess: userAccess ?? this.userAccess,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      accessToken: accessToken ?? this.accessToken,
      loginToken: loginToken ?? this.loginToken,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    return other.userId == userId;
  }

  @override
  int get hashCode =>
      userId.hashCode ^
      outletId.hashCode ^
      mailbox.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      trn.hashCode ^
      phone.hashCode ^
      image.hashCode ^
      mobile.hashCode ^
      tccIssueDate.hashCode ^
      tccExpiryDate.hashCode ^
      businessTrn.hashCode ^
      tcc1.hashCode ^
      dob.hashCode ^
      address1.hashCode ^
      address2.hashCode ^
      city.hashCode ^
      state.hashCode ^
      country.hashCode ^
      postalCode.hashCode ^
      currency.hashCode ^
      location.hashCode ^
      userType.hashCode ^
      loyaltynum.hashCode ^
      roleId.hashCode ^
      isSuperadmin.hashCode ^
      status.hashCode ^
      userAccess.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      accessToken.hashCode ^
      loginToken.hashCode;
}
