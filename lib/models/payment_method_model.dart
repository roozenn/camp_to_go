class PaymentMethod {
  final int id;
  final String methodType;
  final String providerName;
  final String accountNumber;
  final String accountName;
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.methodType,
    required this.providerName,
    required this.accountNumber,
    required this.accountName,
    required this.isDefault,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      methodType: json['method_type'],
      providerName: json['provider_name'],
      accountNumber: json['account_number'],
      accountName: json['account_name'],
      isDefault: json['is_default'],
    );
  }

  String getImageUrl() {
    switch (providerName.toLowerCase()) {
      case 'gopay':
        return 'https://raw.githubusercontent.com/roozenn/camp_to_go/main/lib/image/gopayicon.png';
      case 'ovo':
        return 'https://raw.githubusercontent.com/roozenn/camp_to_go/main/lib/image/ovoicon.jpeg';
      case 'shopeepay':
        return 'https://raw.githubusercontent.com/roozenn/camp_to_go/main/lib/image/spayicon.png';
      default:
        return '';
//Transfer Bank (bank_transfer):
// BCA
// Mandiri
// BNI
// BRI
// E-Wallet (ewallet):
// OVO
// GoPay
// DANA
// LinkAja
// ShopeePay
// Kartu Kredit (credit_card):
// Visa
// Mastercard
// JCB
    }
  }
}
