import 'package:json_annotation/json_annotation.dart';

part 'edit_authorize_user.g.dart';

@JsonSerializable()
class EditAuthorizeUser {
  @JsonKey(name: 'id')
  final String id;

  const EditAuthorizeUser({required this.id});

  factory EditAuthorizeUser.fromJson(Map<String, dynamic> json) {
    return _$EditAuthorizeUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EditAuthorizeUserToJson(this);
}
