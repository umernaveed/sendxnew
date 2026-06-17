// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refferal_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefferalUser _$RefferalUserFromJson(Map<String, dynamic> json) => RefferalUser(
      userId: (json['user_id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      mailbox: json['mailbox'] as String?,
      createdAt: json['created_at'] as String?,
      pendingBalance: json['pending_balance'] ?? '0',
      availableBalance: json['available_balance'] ?? '0',
      description: json['description'] as String?,
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$RefferalUserToJson(RefferalUser instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'first_name': instance.firstName,
      'mailbox': instance.mailbox,
      'created_at': instance.createdAt,
      'pending_balance': instance.pendingBalance,
      'available_balance': instance.availableBalance,
      'description': instance.description,
      'status': instance.status,
    };
