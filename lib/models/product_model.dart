class ProductModel {
  final int id;
  final String name;
  final String imageUrl;
  final double pricePerDay;
  final double originalPrice;
  final int discountPercentage;
  final double rating;
  final int reviewCount;
  final bool isFavorited;

  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.pricePerDay,
    required this.originalPrice,
    required this.discountPercentage,
    required this.rating,
    required this.reviewCount,
    required this.isFavorited,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      pricePerDay: (json['price_per_day'] ?? 0).toDouble(),
      originalPrice: (json['original_price'] ?? 0).toDouble(),
      discountPercentage: json['discount_percentage'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      isFavorited: json['is_favorited'] ?? false,
    );
  }
}
