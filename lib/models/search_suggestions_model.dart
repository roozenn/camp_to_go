class SearchSuggestionsModel {
  final bool success;
  final List<String> suggestions;

  SearchSuggestionsModel({
    required this.success,
    required this.suggestions,
  });

  factory SearchSuggestionsModel.fromJson(Map<String, dynamic> json) {
    return SearchSuggestionsModel(
      success: json['success'] ?? false,
      suggestions: json['data'] != null
          ? List<String>.from(json['data']['suggestions'] ?? [])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': {
        'suggestions': suggestions,
      },
    };
  }
}
