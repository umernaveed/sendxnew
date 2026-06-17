class ChangePassword {
  final String email;

  ChangePassword({
    required this.email,
  });

  factory ChangePassword.fromJson(String source) {
    return ChangePassword(email: source);
  }
}
