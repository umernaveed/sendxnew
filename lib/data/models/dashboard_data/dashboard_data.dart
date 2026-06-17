import 'package:json_annotation/json_annotation.dart';

import 'setting.dart';

part 'dashboard_data.g.dart';

@JsonSerializable()
class DashboardData {
  @JsonKey(name: 'setting', defaultValue: Setting.defaultValues)
  final Setting setting;
  @JsonKey(name: 'outlet_id', defaultValue: '-1')
  final String outletId;
  @JsonKey(name: 'outstanding_package', defaultValue: -1)
  final int outstandingPackage;
  @JsonKey(name: 'in_transit', defaultValue: -1)
  final int inTransit;
  @JsonKey(name: 'outstanding_invoice', defaultValue: -1)
  final int outstandingInvoice;
  @JsonKey(name: 'outstanding_balance', defaultValue: '-1')
  final String outstandingBalance;
  @JsonKey(name: 'wherehouse', defaultValue: -1)
  final int wherehouse;
  @JsonKey(name: 'member_points', defaultValue: -1)
  final num memberPoints;
  @JsonKey(name: 'referral_code', defaultValue: "")
  final String referralCode;
  @JsonKey(name: 'pending_balance', defaultValue: '0')
  final dynamic pendingBalance;
  @JsonKey(name: 'available_balance', defaultValue: 0)
  final int availableBalance;
  @JsonKey(name: 'package_count', defaultValue: 0)
  final int packageCount;
  @JsonKey(name: 'package_weight', defaultValue: 0)
  final dynamic packageWeight;
  @JsonKey(name: 'account_manager', defaultValue: '')
  final String accountManager;
  @JsonKey(name: 'manager_phone', defaultValue: '')
  final String managerPhone;
  @JsonKey(name: 'package_ids', defaultValue: '')
  final String packageIds;
  @JsonKey(name: 'invoice_ids', defaultValue: '')
  final String invoiceIds;

  const DashboardData({
    required this.setting,
    required this.outletId,
    required this.outstandingPackage,
    required this.inTransit,
    required this.outstandingInvoice,
    required this.outstandingBalance,
    required this.wherehouse,
    required this.memberPoints,
    required this.referralCode,
    required this.pendingBalance,
    required this.availableBalance,
    required this.packageCount,
    required this.packageWeight,
    required this.accountManager,
    required this.packageIds,
    required this.invoiceIds,
    required this.managerPhone,
  });

  factory DashboardData.defaultValues() {
    return DashboardData(
      inTransit: 0,
      memberPoints: 0,
      outletId: '-1',
      outstandingBalance: '',
      outstandingInvoice: 0,
      outstandingPackage: 0,
      setting: Setting.defaultValues(),
      wherehouse: 0,
      pendingBalance: 0,
      availableBalance: 0,
      packageCount: 0,
      packageWeight: 0,
      referralCode: '',
      accountManager: '',
      packageIds: '',
      invoiceIds: '',
      managerPhone: '',
    );
  }
  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return _$DashboardDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}
