class ProfileModel {
  final int id;
  final String fullName;
  final String email;
  final String username;
  final String gender;
  final String dateOfBirth;
  final String phoneNumber;
  final String profilePicture;

  ProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.username,
    required this.gender,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.profilePicture,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'username': username,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'phone_number': phoneNumber,
      'profile_picture': profilePicture,
    };
  }
}
