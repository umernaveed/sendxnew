import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'setting.dart';

part 'app_meta.g.dart';

@JsonSerializable()
class AppMeta {
  final Setting? setting;

  const AppMeta({this.setting});

  factory AppMeta.fromJson(Map<String, dynamic> json) {
    return _$AppMetaFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppMetaToJson(this);

  AppMeta copyWith({
    Setting? setting,
  }) {
    return AppMeta(
      setting: setting ?? this.setting,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AppMeta) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => setting.hashCode;
}
