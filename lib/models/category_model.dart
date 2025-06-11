class CategoryModel {
  final int id;
  final String name;
  final String? description;
  final String? iconUrl;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.iconUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      iconUrl: json['icon_url'] as String?,
    );
  }
}
