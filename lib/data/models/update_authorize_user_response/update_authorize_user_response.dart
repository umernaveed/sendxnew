import 'package:json_annotation/json_annotation.dart';

part 'update_authorize_user_response.g.dart';

@JsonSerializable()
class UpdateAuthorizeUserResponse {
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'proof')
  final String proof;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  const UpdateAuthorizeUserResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.proof,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UpdateAuthorizeUserResponse.fromJson(Map<String, dynamic> json) {
    return _$UpdateAuthorizeUserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateAuthorizeUserResponseToJson(this);
}
