import 'package:json_annotation/json_annotation.dart';

part 'update_authorize_user.g.dart';

@JsonSerializable()
class UpdateAuthorizeUser {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'proof')
  final String proof;

  const UpdateAuthorizeUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.proof,
  });

  factory UpdateAuthorizeUser.fromJson(Map<String, dynamic> json) {
    return _$UpdateAuthorizeUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateAuthorizeUserToJson(this);
}
