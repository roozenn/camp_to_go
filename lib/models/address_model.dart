class Address {
  final int id;
  final String recipientName;
  final String fullAddress;
  final String phoneNumber;
  final bool isDefault;

  Address({
    required this.id,
    required this.recipientName,
    required this.fullAddress,
    required this.phoneNumber,
    required this.isDefault,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      recipientName: json['recipient_name'],
      fullAddress: json['full_address'],
      phoneNumber: json['phone_number'],
      isDefault: json['is_default'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipient_name': recipientName,
      'full_address': fullAddress,
      'phone_number': phoneNumber,
      'is_default': isDefault,
    };
  }
}
