import 'package:json_annotation/json_annotation.dart';

part 'update_purchase_request.g.dart';

@JsonSerializable()
class UpdatePurchaseRequest {
  final int? id;
  final String? name;
  final String? link;
  final int? qty;
  final String? notes;

  const UpdatePurchaseRequest({
    this.id,
    this.name,
    this.link,
    this.qty,
    this.notes,
  });

  factory UpdatePurchaseRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdatePurchaseRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdatePurchaseRequestToJson(this);

  UpdatePurchaseRequest copyWith({
    int? id,
    String? name,
    String? link,
    int? qty,
    String? notes,
  }) {
    return UpdatePurchaseRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      link: link ?? this.link,
      qty: qty ?? this.qty,
      notes: notes ?? this.notes,
    );
  }
}
