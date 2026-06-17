import 'package:json_annotation/json_annotation.dart';

part 'add_purchas_request.g.dart';

@JsonSerializable()
class AddPurchasRequest {
  final String? name;
  final String? link;
  final int? qty;
  final String? notes;

  const AddPurchasRequest({this.name, this.link, this.qty, this.notes});

  factory AddPurchasRequest.fromJson(Map<String, dynamic> json) {
    return _$AddPurchasRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddPurchasRequestToJson(this);

  AddPurchasRequest copyWith({
    String? name,
    String? link,
    int? qty,
    String? notes,
  }) {
    return AddPurchasRequest(
      name: name ?? this.name,
      link: link ?? this.link,
      qty: qty ?? this.qty,
      notes: notes ?? this.notes,
    );
  }
}
