import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'device_type')
  final String deviceType;
  @JsonKey(name: 'device_token')
  final String deviceToken;
  @JsonKey(name: 'app_version')
  final String appVersion;
  @JsonKey(name: 'time_zone')
  final String timeZone;

  const LoginRequest({
    required this.email,
    required this.password,
    required this.deviceType,
    required this.deviceToken,
    required this.appVersion,
    required this.timeZone,
  });

  @override
  String toString() {
    return 'LoginRequest(email: $email, password: $password, deviceType: $deviceType, deviceToken: $deviceToken, appVersion: $appVersion, timeZone: $timeZone)';
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return _$LoginRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
