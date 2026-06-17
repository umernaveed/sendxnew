// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Purchase _$PurchaseFromJson(Map<String, dynamic> json) => Purchase(
      id: (json['id'] as num?)?.toInt() ?? -1,
      userId: json['user_id'] ?? '',
      name: json['name'] as String? ?? '',
      link: json['link'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      qty: (json['qty'] as num?)?.toInt() ?? -1,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );

Map<String, dynamic> _$PurchaseToJson(Purchase instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'link': instance.link,
      'notes': instance.notes,
      'qty': instance.qty,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
