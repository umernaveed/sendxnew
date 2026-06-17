class ForgetPassword {
  final String email;

  ForgetPassword({
    required this.email,
  });

  factory ForgetPassword.fromJson(String source) {
    return ForgetPassword(email: source);
  }
}
