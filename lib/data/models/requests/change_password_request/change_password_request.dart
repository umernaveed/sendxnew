import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  @JsonKey(name: 'old_pass')
  final String oldPass;
  @JsonKey(name: 'new_pass')
  final String newPass;

  const ChangePasswordRequest({
    required this.oldPass,
    required this.newPass,
  });

  @override
  String toString() {
    return 'ChangePasswordRequest(oldPass: $oldPass, newPass: $newPass)';
  }

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
