import 'package:camp_to_go/models/category_model.dart';

class ProductDetailModel {
  final int id;
  final String name;
  final String description;
  final double pricePerDay;
  final double originalPrice;
  final int discountPercentage;
  final double depositAmount;
  final double rating;
  final int reviewCount;
  final int stockQuantity;
  final CategoryModel category;
  final List<ProductImageModel> images;
  final List<ProductReviewModel> reviews;
  final bool isFavorited;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pricePerDay,
    required this.originalPrice,
    required this.discountPercentage,
    required this.depositAmount,
    required this.rating,
    required this.reviewCount,
    required this.stockQuantity,
    required this.category,
    required this.images,
    required this.reviews,
    required this.isFavorited,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    print('Parsing product detail JSON: $json'); // Debug print

    // Handle nested data structure
    final data = json['data'] as Map<String, dynamic>? ?? json;

    return ProductDetailModel(
      id: data['id'] as int? ?? 0,
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      pricePerDay: (data['price_per_day'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (data['original_price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage: (data['discount_percentage'] as num?)?.toInt() ?? 0,
      depositAmount: (data['deposit_amount'] as num?)?.toDouble() ?? 0.0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (data['review_count'] as num?)?.toInt() ?? 0,
      stockQuantity: (data['stock_quantity'] as num?)?.toInt() ?? 0,
      category: data['category'] != null
          ? CategoryModel.fromJson(data['category'] as Map<String, dynamic>)
          : CategoryModel(id: 0, name: ''),
      images: (data['images'] as List<dynamic>?)
              ?.map(
                  (e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      reviews: [], // Reviews will be populated separately
      isFavorited: data['is_favorited'] as bool? ?? false,
    );
  }
}

class ProductImageModel {
  final int id;
  final String imageUrl;
  final bool isPrimary;

  ProductImageModel({
    required this.id,
    required this.imageUrl,
    required this.isPrimary,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: json['id'],
      imageUrl: json['image_url'],
      isPrimary: json['is_primary'],
    );
  }
}

class ProductReviewModel {
  final int id;
  final String userName;
  final String userProfilePicture;
  final int rating;
  final String comment;
  final List<String> images;
  final DateTime createdAt;

  ProductReviewModel({
    required this.id,
    required this.userName,
    required this.userProfilePicture,
    required this.rating,
    required this.comment,
    required this.images,
    required this.createdAt,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};
    return ProductReviewModel(
      id: json['id'] as int? ?? 0,
      userName: user['name'] as String? ?? 'Anonymous',
      userProfilePicture: user['profile_picture'] as String? ?? '',
      rating: json['rating'] as int? ?? 0,
      comment: json['comment'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}

class RecommendedProductModel {
  final int id;
  final String name;
  final double pricePerDay;
  final double originalPrice;
  final int discountPercentage;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final bool isFavorited;

  RecommendedProductModel({
    required this.id,
    required this.name,
    required this.pricePerDay,
    required this.originalPrice,
    required this.discountPercentage,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.isFavorited,
  });

  factory RecommendedProductModel.fromJson(Map<String, dynamic> json) {
    return RecommendedProductModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      pricePerDay: (json['price_per_day'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['original_price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage: (json['discount_percentage'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
      isFavorited: json['is_favorited'] as bool? ?? false,
    );
  }

  // Convert to ProductDetailModel for display
  ProductDetailModel toProductDetailModel() {
    return ProductDetailModel(
      id: id,
      name: name,
      description: '', // Tidak ada di data rekomendasi
      pricePerDay: pricePerDay,
      originalPrice: originalPrice,
      discountPercentage: discountPercentage,
      depositAmount: 0, // Tidak ada di data rekomendasi
      rating: rating,
      reviewCount: reviewCount,
      stockQuantity: 0, // Tidak ada di data rekomendasi
      category: CategoryModel(id: 0, name: ''), // Tidak ada di data rekomendasi
      images: [ProductImageModel(id: id, imageUrl: imageUrl, isPrimary: true)],
      reviews: [], // Tidak ada di data rekomendasi
      isFavorited: isFavorited,
    );
  }
}
