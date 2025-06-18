import 'dart:async';
import 'package:get/get.dart';
import '../services/api_service.dart';

class SearchController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  final RxList<String> searchSuggestions = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  Timer? _debounceTimer;

  // Get search suggestions from API
  Future<void> getSearchSuggestions(String query) async {
    if (query.trim().isEmpty) {
      searchSuggestions.clear();
      return;
    }

    isLoading.value = true;
    try {
      final suggestions = await _apiService.getSearchSuggestions(query);
      searchSuggestions.value = suggestions;
    } catch (e) {
      print('Error getting search suggestions: $e');
      searchSuggestions.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // Update search query and get suggestions with debouncing
  void updateSearchQuery(String query) {
    searchQuery.value = query;

    // Cancel previous timer
    _debounceTimer?.cancel();

    // Set new timer for debouncing (500ms delay)
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      getSearchSuggestions(query);
    });
  }

  // Clear search
  void clearSearch() {
    searchQuery.value = '';
    searchSuggestions.clear();
    _debounceTimer?.cancel();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}
