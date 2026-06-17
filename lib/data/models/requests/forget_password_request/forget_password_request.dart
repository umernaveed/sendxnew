import 'package:json_annotation/json_annotation.dart';

part 'forget_password_request.g.dart';

@JsonSerializable()
class ForgetPasswordRequest {
  final String email;

  const ForgetPasswordRequest({required this.email});

  @override
  String toString() => 'ForgetPasswordRequest(email: $email)';

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestToJson(this);
}
