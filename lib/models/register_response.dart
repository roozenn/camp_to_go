class RegisterResponse {
  final bool success;
  final String message;
  final RegisterData? data;

  RegisterResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? RegisterData.fromJson(json['data']) : null,
    );
  }
}

class RegisterData {
  final int userId;
  final String email;
  final String fullName;

  RegisterData({
    required this.userId,
    required this.email,
    required this.fullName,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      userId: json['user_id'] ?? 0,
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? '',
    );
  }
}
