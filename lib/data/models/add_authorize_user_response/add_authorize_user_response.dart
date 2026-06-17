import 'package:json_annotation/json_annotation.dart';

part 'add_authorize_user_response.g.dart';

@JsonSerializable()
class AddAuthorizeUserResponse {
  @JsonKey(name: 'user_id')
  final int? userId;
  final String? name;
  final String? phone;
  final String? proof;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final int? id;

  const AddAuthorizeUserResponse({
    this.userId,
    this.name,
    this.phone,
    this.proof,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory AddAuthorizeUserResponse.fromJson(Map<String, dynamic> json) {
    return _$AddAuthorizeUserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddAuthorizeUserResponseToJson(this);
}
