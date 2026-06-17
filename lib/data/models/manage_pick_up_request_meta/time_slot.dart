import 'package:json_annotation/json_annotation.dart';

part 'time_slot.g.dart';

@JsonSerializable()
class TimeSlot {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'area_id')
  final int areaId;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;
  @JsonKey(name: 'num_of_requests')
  final int numberOfRequests;
  @JsonKey(name: 'available_count')
  final int availableCount;
  @JsonKey(name: 'day_id')
  final int? dayId;
  @JsonKey(name: 'type')
  final int? type;

  TimeSlot({
    required this.id,
    required this.areaId,
    required this.startTime,
    required this.endTime,
    required this.numberOfRequests,
    required this.availableCount,
    this.dayId,
    this.type,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return _$TimeSlotFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}
