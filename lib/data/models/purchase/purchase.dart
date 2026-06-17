import 'package:json_annotation/json_annotation.dart';

part 'purchase.g.dart';

@JsonSerializable()
class Purchase {
  @JsonKey(name: 'id', defaultValue: -1)
  final int id;
  @JsonKey(name: 'user_id', defaultValue: '')
  final dynamic userId;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'link', defaultValue: '')
  final String link;
  @JsonKey(name: 'notes', defaultValue: '')
  final String notes;
  @JsonKey(name: 'qty', defaultValue: -1)
  final int qty;
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;
  @JsonKey(name: 'updated_at', defaultValue: '')
  final String updatedAt;

  const Purchase({
    required this.id,
    required this.userId,
    required this.name,
    required this.link,
    required this.notes,
    required this.qty,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return _$PurchaseFromJson(json);
  }
  factory Purchase.empty() {
    return const Purchase(
      createdAt: '',
      id: -1,
      link: '',
      name: '',
      notes: '',
      qty: 0,
      updatedAt: '',
      userId: '',
    );
  }

  Map<String, dynamic> toJson() => _$PurchaseToJson(this);
}

class AllPurchases {
  final List<Purchase> purchases;

  AllPurchases({required this.purchases});

  factory AllPurchases.fromJson(List<dynamic> json) {
    return AllPurchases(
      purchases: json
          .map((e) => Purchase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
