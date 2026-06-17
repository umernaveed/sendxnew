import 'package:json_annotation/json_annotation.dart';

import 'setting.dart';
import 'user_info.dart';

part 'dashboard_address_data.g.dart';

@JsonSerializable()
class DashboardAddressData {
  @JsonKey(name: 'setting', defaultValue: Setting.dashboardAddressSetting)
  final Setting setting;
  @JsonKey(name: 'user_info', defaultValue: UserInfo.empty)
  final UserInfo userInfo;

  const DashboardAddressData({required this.setting, required this.userInfo});

  factory DashboardAddressData.fromJson(Map<String, dynamic> json) {
    return _$DashboardAddressDataFromJson(json);
  }

  factory DashboardAddressData.defaultValues() {
    return DashboardAddressData(
      setting: Setting.dashboardAddressSetting(),
      userInfo: UserInfo.empty(),
    );
  }

  Map<String, dynamic> toJson() => _$DashboardAddressDataToJson(this);
}
