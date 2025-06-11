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
      id: json['id'] as int? ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
      isPrimary: json['is_primary'] as bool? ?? false,
    );
  }
}
