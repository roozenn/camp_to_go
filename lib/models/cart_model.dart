class CartProduct {
  final int id;
  final String name;
  final String imageUrl;
  final double pricePerDay;
  final double depositAmount;

  CartProduct({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.pricePerDay,
    required this.depositAmount,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      pricePerDay: (json['price_per_day'] as num).toDouble(),
      depositAmount: (json['deposit_amount'] as num).toDouble(),
    );
  }
}

class CartItem {
  final int id;
  final CartProduct product;
  final String startDate;
  final String endDate;
  final int daysCount;
  final int quantity;
  final double subtotal;
  final double depositSubtotal;

  CartItem({
    required this.id,
    required this.product,
    required this.startDate,
    required this.endDate,
    required this.daysCount,
    required this.quantity,
    required this.subtotal,
    required this.depositSubtotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as int,
      product: CartProduct.fromJson(json['product'] as Map<String, dynamic>),
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      daysCount: json['days_count'] as int,
      quantity: json['quantity'] as int,
      subtotal: (json['subtotal'] as num).toDouble(),
      depositSubtotal: (json['deposit_subtotal'] as num).toDouble(),
    );
  }
}

class CartSummary {
  final double totalRental;
  final double totalDeposit;
  final double totalAmount;

  CartSummary({
    required this.totalRental,
    required this.totalDeposit,
    required this.totalAmount,
  });

  factory CartSummary.fromJson(Map<String, dynamic> json) {
    return CartSummary(
      totalRental: (json['total_rental'] as num).toDouble(),
      totalDeposit: (json['total_deposit'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
    );
  }
}

class CartResponse {
  final List<CartItem> items;
  final CartSummary summary;

  CartResponse({
    required this.items,
    required this.summary,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      summary: CartSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );
  }
}
