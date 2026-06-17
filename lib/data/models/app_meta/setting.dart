import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable()
class Setting {
  @JsonKey(name: 'site_name')
  final String? siteName;
  @JsonKey(name: 'base_url')
  final String? baseUrl;
  @JsonKey(name: 'app_logo')
  final String? appLogo;
  @JsonKey(name: 'site_title')
  final String? siteTitle;
  @JsonKey(name: 'btn_color')
  final String? btnColor;
  @JsonKey(name: 'text_color')
  final String? textColor;
  @JsonKey(name: 'app_version')
  final String? appVersion;

  const Setting({
    this.siteName,
    this.baseUrl,
    this.appLogo,
    this.siteTitle,
    this.btnColor,
    this.textColor,
    this.appVersion,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return _$SettingFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SettingToJson(this);

  Setting copyWith({
    String? siteName,
    String? baseUrl,
    String? appLogo,
    String? siteTitle,
    String? btnColor,
    String? textColor,
    String? appVersion,
  }) {
    return Setting(
      siteName: siteName ?? this.siteName,
      baseUrl: baseUrl ?? this.baseUrl,
      appLogo: appLogo ?? this.appLogo,
      siteTitle: siteTitle ?? this.siteTitle,
      btnColor: btnColor ?? this.btnColor,
      textColor: textColor ?? this.textColor,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Setting) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      siteName.hashCode ^
      baseUrl.hashCode ^
      appLogo.hashCode ^
      siteTitle.hashCode ^
      btnColor.hashCode ^
      textColor.hashCode;
}
