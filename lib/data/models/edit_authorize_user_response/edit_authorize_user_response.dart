import 'package:json_annotation/json_annotation.dart';

part 'edit_authorize_user_response.g.dart';

@JsonSerializable()
class EditAuthorizeUserResponse {
  final int? id;
  @JsonKey(name: 'user_id')
  final int? userId;
  final String? name;
  final String? phone;
  final String? proof;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  const EditAuthorizeUserResponse({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.proof,
    this.createdAt,
    this.updatedAt,
  });

  factory EditAuthorizeUserResponse.fromJson(Map<String, dynamic> json) {
    return _$EditAuthorizeUserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EditAuthorizeUserResponseToJson(this);
}
