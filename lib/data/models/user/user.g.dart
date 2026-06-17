// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      userId: fields[0] as int,
      outletId: fields[1] as String,
      mailbox: fields[2] as String,
      firstName: fields[3] as String,
      lastName: fields[4] as String,
      userName: fields[5] as String,
      email: fields[6] as String,
      password: fields[7] as String,
      trn: fields[8] as String,
      phone: fields[9] as String,
      image: fields[10] as String,
      mobile: fields[11] as String,
      tccIssueDate: fields[12] as String,
      tccExpiryDate: fields[13] as String,
      businessTrn: fields[14] as String,
      tcc1: fields[15] as String,
      dob: fields[16] as String,
      address1: fields[17] as String,
      address2: fields[18] as String,
      city: fields[19] as String,
      state: fields[20] as String,
      country: fields[21] as String,
      postalCode: fields[22] as String,
      currency: fields[23] as String,
      location: fields[24] as String,
      userType: fields[25] as String,
      loyaltynum: fields[26] as String,
      roleId: fields[27] as int,
      isSuperadmin: fields[28] as int,
      status: fields[29] as String,
      userAccess: fields[30] as int,
      createdAt: fields[31] as String,
      updatedAt: fields[32] as String,
      accessToken: fields[33] as String,
      loginToken: fields[34] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(35)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.outletId)
      ..writeByte(2)
      ..write(obj.mailbox)
      ..writeByte(3)
      ..write(obj.firstName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.userName)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.password)
      ..writeByte(8)
      ..write(obj.trn)
      ..writeByte(9)
      ..write(obj.phone)
      ..writeByte(10)
      ..write(obj.image)
      ..writeByte(11)
      ..write(obj.mobile)
      ..writeByte(12)
      ..write(obj.tccIssueDate)
      ..writeByte(13)
      ..write(obj.tccExpiryDate)
      ..writeByte(14)
      ..write(obj.businessTrn)
      ..writeByte(15)
      ..write(obj.tcc1)
      ..writeByte(16)
      ..write(obj.dob)
      ..writeByte(17)
      ..write(obj.address1)
      ..writeByte(18)
      ..write(obj.address2)
      ..writeByte(19)
      ..write(obj.city)
      ..writeByte(20)
      ..write(obj.state)
      ..writeByte(21)
      ..write(obj.country)
      ..writeByte(22)
      ..write(obj.postalCode)
      ..writeByte(23)
      ..write(obj.currency)
      ..writeByte(24)
      ..write(obj.location)
      ..writeByte(25)
      ..write(obj.userType)
      ..writeByte(26)
      ..write(obj.loyaltynum)
      ..writeByte(27)
      ..write(obj.roleId)
      ..writeByte(28)
      ..write(obj.isSuperadmin)
      ..writeByte(29)
      ..write(obj.status)
      ..writeByte(30)
      ..write(obj.userAccess)
      ..writeByte(31)
      ..write(obj.createdAt)
      ..writeByte(32)
      ..write(obj.updatedAt)
      ..writeByte(33)
      ..write(obj.accessToken)
      ..writeByte(34)
      ..write(obj.loginToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: (json['user_id'] as num?)?.toInt() ?? -1,
      outletId: json['outlet_id'] as String? ?? '-1',
      mailbox: json['mailbox'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      trn: json['trn'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      image: json['image'] as String? ?? '',
      mobile: json['mobile'] as String? ?? '',
      tccIssueDate: json['tcc_issue_date'] as String? ?? '',
      tccExpiryDate: json['tcc_expiry_date'] as String? ?? '',
      businessTrn: json['Business_trn'] as String? ?? '',
      tcc1: json['tcc1'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      address1: json['address_1'] as String? ?? '',
      address2: json['address_2'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
      postalCode: json['postal_code'] as String? ?? '',
      currency: json['currency'] as String? ?? 'JMD',
      location: json['location'] as String? ?? '',
      userType: json['user_type'] as String? ?? 'Regular User',
      loyaltynum: json['loyaltynum'] as String? ?? '',
      roleId: (json['role_id'] as num?)?.toInt() ?? -1,
      isSuperadmin: (json['is_superadmin'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? '',
      userAccess: (json['user_access'] as num?)?.toInt() ?? 1,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      accessToken: json['accessToken'] as String? ?? '',
      loginToken: json['loginToken'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.userId,
      'outlet_id': instance.outletId,
      'mailbox': instance.mailbox,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_name': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'trn': instance.trn,
      'phone': instance.phone,
      'image': instance.image,
      'mobile': instance.mobile,
      'tcc_issue_date': instance.tccIssueDate,
      'tcc_expiry_date': instance.tccExpiryDate,
      'Business_trn': instance.businessTrn,
      'tcc1': instance.tcc1,
      'dob': instance.dob,
      'address_1': instance.address1,
      'address_2': instance.address2,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postal_code': instance.postalCode,
      'currency': instance.currency,
      'location': instance.location,
      'user_type': instance.userType,
      'loyaltynum': instance.loyaltynum,
      'role_id': instance.roleId,
      'is_superadmin': instance.isSuperadmin,
      'status': instance.status,
      'user_access': instance.userAccess,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'accessToken': instance.accessToken,
      'loginToken': instance.loginToken,
    };
