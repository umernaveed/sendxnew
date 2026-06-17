import 'package:json_annotation/json_annotation.dart';

part 'delete_authorize_user.g.dart';

@JsonSerializable()
class DeleteAuthorizeUser {
  @JsonKey(name: 'id')
  final String id;

  const DeleteAuthorizeUser({required this.id});

  factory DeleteAuthorizeUser.fromJson(Map<String, dynamic> json) {
    return _$DeleteAuthorizeUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeleteAuthorizeUserToJson(this);
}
