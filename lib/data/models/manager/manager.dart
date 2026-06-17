import 'package:json_annotation/json_annotation.dart';

part 'manager.g.dart';

@JsonSerializable()
class Manager {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;

  Manager({required this.id, required this.name});

  factory Manager.fromJson(Map<String, dynamic> json) =>
      _$ManagerFromJson(json);

  Map<String, dynamic> toJson() => _$ManagerToJson(this);
}

class Managers {
  final List<Manager> managers;

  Managers({required this.managers});

  factory Managers.fromJson(List<dynamic> json) {
    return Managers(
      managers:
          json.map((i) => Manager.fromJson(i as Map<String, dynamic>)).toList(),
    );
  }
}
