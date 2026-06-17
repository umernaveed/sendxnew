class LogOutResponse {
  final String token;

  LogOutResponse({
    required this.token,
  });

  factory LogOutResponse.fromJson(Map<String, dynamic> map) {
    return LogOutResponse(
      token: map['login_token'] as String,
    );
  }
}
