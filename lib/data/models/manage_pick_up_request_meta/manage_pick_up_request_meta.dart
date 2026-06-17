import 'package:json_annotation/json_annotation.dart';

import 'area.dart';
import 'day.dart';

part 'manage_pick_up_request_meta.g.dart';

@JsonSerializable()
class ManagePickUpRequestMeta {
  final List<Area>? areas;
  final List<Day>? days;

  const ManagePickUpRequestMeta({this.areas, this.days});

  factory ManagePickUpRequestMeta.fromJson(Map<String, dynamic> json) {
    return _$ManagePickUpRequestMetaFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ManagePickUpRequestMetaToJson(this);
}
