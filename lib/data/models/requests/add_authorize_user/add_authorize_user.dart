import 'package:json_annotation/json_annotation.dart';

part 'add_authorize_user.g.dart';

@JsonSerializable()
class AddAuthorizeUser {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'proof')
  final String proof;

  const AddAuthorizeUser({
    required this.name,
    required this.phone,
    required this.proof,
  });

  factory AddAuthorizeUser.fromJson(Map<String, dynamic> json) {
    return _$AddAuthorizeUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddAuthorizeUserToJson(this);

  AddAuthorizeUser copyWith({
    String? name,
    String? phone,
    String? proof,
  }) {
    return AddAuthorizeUser(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      proof: proof ?? this.proof,
    );
  }
}
