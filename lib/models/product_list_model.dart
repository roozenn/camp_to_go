class ProductListModel {
  final bool success;
  final List<ProductItemModel> products;
  final PaginationModel pagination;

  ProductListModel({
    required this.success,
    required this.products,
    required this.pagination,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      success: json['success'] ?? false,
      products: json['data'] != null && json['data']['products'] != null
          ? (json['data']['products'] as List)
              .map((item) => ProductItemModel.fromJson(item))
              .toList()
          : [],
      pagination: json['data'] != null && json['data']['pagination'] != null
          ? PaginationModel.fromJson(json['data']['pagination'])
          : PaginationModel.empty(),
    );
  }
}

class ProductItemModel {
  final int id;
  final String name;
  final double pricePerDay;
  final double originalPrice;
  final int discountPercentage;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final bool isFavorited;

  ProductItemModel({
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

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      pricePerDay: (json['price_per_day'] ?? 0).toDouble(),
      originalPrice: (json['original_price'] ?? 0).toDouble(),
      discountPercentage: json['discount_percentage'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      isFavorited: json['is_favorited'] ?? false,
    );
  }
}

class PaginationModel {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNext;
  final bool hasPrev;

  PaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasNext,
    required this.hasPrev,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
      totalItems: json['total_items'] ?? 0,
      hasNext: json['has_next'] ?? false,
      hasPrev: json['has_prev'] ?? false,
    );
  }

  factory PaginationModel.empty() {
    return PaginationModel(
      currentPage: 1,
      totalPages: 1,
      totalItems: 0,
      hasNext: false,
      hasPrev: false,
    );
  }
}
