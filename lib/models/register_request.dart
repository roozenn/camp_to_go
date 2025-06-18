class RegisterRequest {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    };
  }
}
