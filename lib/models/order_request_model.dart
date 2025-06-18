class OrderRequestModel {
  final int addressId;
  final int paymentMethodId;
  final String? couponCode;
  final String? notes;

  OrderRequestModel({
    required this.addressId,
    required this.paymentMethodId,
    this.couponCode,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'address_id': addressId,
      'payment_method_id': paymentMethodId,
    };

    if (couponCode != null && couponCode!.isNotEmpty) {
      data['coupon_code'] = couponCode;
    }

    if (notes != null && notes!.isNotEmpty) {
      data['notes'] = notes;
    }

    return data;
  }
}

class OrderResponseModel {
  final int orderId;
  final String orderNumber;
  final double totalAmount;

  OrderResponseModel({
    required this.orderId,
    required this.orderNumber,
    required this.totalAmount,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      orderId: json['order_id'] ?? 0,
      orderNumber: json['order_number'] ?? '',
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
    );
  }
}
