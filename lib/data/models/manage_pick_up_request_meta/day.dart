import 'package:json_annotation/json_annotation.dart';
import 'package:sendx/presentation/auth/widgets/drop_down.dart';

part 'day.g.dart';

@JsonSerializable()
class Day extends Pair {
  final int? id;
  @JsonKey(name: 'day_id')
  final String? dayId;
  final String? day;

  Day({
    this.id,
    this.dayId,
    this.day,
  }) : super(value: day.toString(), key: '$id');

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  Map<String, dynamic> toJson() => _$DayToJson(this);
}
