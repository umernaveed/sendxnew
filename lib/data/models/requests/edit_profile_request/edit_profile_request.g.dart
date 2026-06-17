// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileRequest _$EditProfileRequestFromJson(Map<String, dynamic> json) =>
    EditProfileRequest(
      userType: json['user_type'] as String,
      outletId: json['outlet_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      trn: json['trn'] as String,
      mobile: json['mobile'] as String,
      tccIssueDate: json['tcc_issue_date'] as String,
      tccExpiryDate: json['tcc_expiry_date'] as String,
      businessTrn: json['Business_trn'] as String,
      address1: json['address_1'] as String,
      address2: json['address_2'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$EditProfileRequestToJson(EditProfileRequest instance) =>
    <String, dynamic>{
      'user_type': instance.userType,
      'outlet_id': instance.outletId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'trn': instance.trn,
      'mobile': instance.mobile,
      'tcc_issue_date': instance.tccIssueDate,
      'tcc_expiry_date': instance.tccExpiryDate,
      'Business_trn': instance.businessTrn,
      'address_1': instance.address1,
      'address_2': instance.address2,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };
