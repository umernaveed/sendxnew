import 'package:json_annotation/json_annotation.dart';

part 'outlet.g.dart';

@JsonSerializable()
class Outlet {
  @JsonKey(name: 'outlet_id', defaultValue: '')
  final String outletId;
  @JsonKey(name: 'outlet_name', defaultValue: '')
  final String outletName;

  const Outlet({required this.outletId, required this.outletName});

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return _$OutletFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OutletToJson(this);
}

class OutLet {
  final List<Outlet> outLets;

  OutLet({required this.outLets});

  factory OutLet.fromJson(List<dynamic> json) {
    return OutLet(
      outLets: json.map((e) => Outlet.fromJson(e)).toList(),
    );
  }
}
