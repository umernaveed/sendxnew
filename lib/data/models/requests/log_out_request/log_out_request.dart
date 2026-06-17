import 'package:json_annotation/json_annotation.dart';

part 'log_out_request.g.dart';

@JsonSerializable()
class LogOutRequest {
  @JsonKey(name: 'login_token')
  final String loginToken;

  const LogOutRequest({required this.loginToken});

  @override
  String toString() => 'LogOutRequest(loginToken: $loginToken)';

  factory LogOutRequest.fromJson(Map<String, dynamic> json) {
    return _$LogOutRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LogOutRequestToJson(this);
}
