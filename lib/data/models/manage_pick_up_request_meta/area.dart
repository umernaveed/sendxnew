import 'package:json_annotation/json_annotation.dart';
import 'package:sendx/data/models/manage_pick_up_request_meta/time_slot.dart';
import 'package:sendx/presentation/auth/widgets/drop_down.dart';

part 'area.g.dart';

@JsonSerializable()
class Area extends Pair {
  final int? id;
  final String? name;
  final String? cost;
  final int? status;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'timeslots')
  final List<TimeSlot>? timeSlots;

  Area({
    this.id,
    this.name,
    this.cost,
    this.status,
    this.createdAt,
    this.timeSlots,
  }) : super(value: name.toString(), key: '$id');

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToJson(this);
}
