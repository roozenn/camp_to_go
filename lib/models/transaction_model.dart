class TransactionModel {
  final int id;
  final String orderNumber;
  final String status;
  final String notes;
  final double totalAmount;
  final double discountAmount;
  final double depositTotal;
  final String createdAt;
  final String shippingDate;
  final String returnDate;
  final List<TransactionItem> items;

  TransactionModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.notes,
    required this.totalAmount,
    required this.discountAmount,
    required this.depositTotal,
    required this.createdAt,
    required this.shippingDate,
    required this.returnDate,
    required this.items,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    print('Parsing transaction: $json'); // Debug print

    return TransactionModel(
      id: json['id'] ?? 0,
      orderNumber: json['order_number'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'] ?? '',
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      depositTotal: (json['deposit_total'] ?? 0).toDouble(),
      createdAt: json['created_at'] ?? '',
      shippingDate: json['shipping_date'] ?? '',
      returnDate: json['return_date'] ?? '',
      items: (json['items'] as List?)
              ?.map((item) => TransactionItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class TransactionItem {
  final int id;
  final int productId;
  final String productName;
  final int quantity;
  final String startDate;
  final String endDate;
  final double subtotal;
  final double depositSubtotal;

  TransactionItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.startDate,
    required this.endDate,
    required this.subtotal,
    required this.depositSubtotal,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    print('Parsing item: $json'); // Debug print

    return TransactionItem(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      productName: json['product']?['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      depositSubtotal: (json['deposit_subtotal'] ?? 0).toDouble(),
    );
  }
}
