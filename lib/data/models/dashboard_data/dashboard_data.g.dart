// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      setting: json['setting'] == null
          ? Setting.defaultValues()
          : Setting.fromJson(json['setting'] as Map<String, dynamic>),
      outletId: json['outlet_id'] as String? ?? '-1',
      outstandingPackage: (json['outstanding_package'] as num?)?.toInt() ?? -1,
      inTransit: (json['in_transit'] as num?)?.toInt() ?? -1,
      outstandingInvoice: (json['outstanding_invoice'] as num?)?.toInt() ?? -1,
      outstandingBalance: json['outstanding_balance'] as String? ?? '-1',
      wherehouse: (json['wherehouse'] as num?)?.toInt() ?? -1,
      memberPoints: json['member_points'] as num? ?? -1,
      referralCode: json['referral_code'] as String? ?? '',
      pendingBalance: json['pending_balance'] ?? '0',
      availableBalance: (json['available_balance'] as num?)?.toInt() ?? 0,
      packageCount: (json['package_count'] as num?)?.toInt() ?? 0,
      packageWeight: json['package_weight'] ?? 0,
      accountManager: json['account_manager'] as String? ?? '',
      packageIds: json['package_ids'] as String? ?? '',
      invoiceIds: json['invoice_ids'] as String? ?? '',
      managerPhone: json['manager_phone'] as String? ?? '',
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'setting': instance.setting,
      'outlet_id': instance.outletId,
      'outstanding_package': instance.outstandingPackage,
      'in_transit': instance.inTransit,
      'outstanding_invoice': instance.outstandingInvoice,
      'outstanding_balance': instance.outstandingBalance,
      'wherehouse': instance.wherehouse,
      'member_points': instance.memberPoints,
      'referral_code': instance.referralCode,
      'pending_balance': instance.pendingBalance,
      'available_balance': instance.availableBalance,
      'package_count': instance.packageCount,
      'package_weight': instance.packageWeight,
      'account_manager': instance.accountManager,
      'manager_phone': instance.managerPhone,
      'package_ids': instance.packageIds,
      'invoice_ids': instance.invoiceIds,
    };
