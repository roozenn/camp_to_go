import 'dart:async';
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/product_list_model.dart';

class FavoriteController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  final RxList<ProductItemModel> favorites = <ProductItemModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxString sortBy = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasNextPage = false.obs;
  final RxBool hasPrevPage = false.obs;
  final RxInt totalItems = 0.obs;

  // Filter state
  final RxString selectedCategory = ''.obs;
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 0.0.obs;
  final RxBool hasActiveFilters = false.obs;

  Timer? _debounceTimer;

  // Category mapping
  final Map<String, int> categoryMapping = {
    'Tenda': 1,
    'Alat Tidur': 2,
    'Masak': 3,
    'Sepatu': 4,
    'Tas': 5,
  };

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  // Load favorites with current filters
  Future<void> loadFavorites({bool refresh = false}) async {
    if (refresh) {
      currentPage.value = 1;
    }

    isLoading.value = true;
    try {
      // Get category ID from selected category
      int? categoryId;
      if (selectedCategory.value.isNotEmpty) {
        categoryId = categoryMapping[selectedCategory.value];
      }

      final result = await _apiService.getFavorites(
        categoryId: categoryId,
        search: searchQuery.value.isNotEmpty ? searchQuery.value : null,
        sortBy: sortBy.value.isNotEmpty ? sortBy.value : null,
        minPrice: minPrice.value > 0 ? minPrice.value : null,
        maxPrice: maxPrice.value > 0 ? maxPrice.value : null,
        page: currentPage.value,
        limit: 20,
      );

      if (result.success) {
        if (refresh) {
          favorites.clear();
        }
        favorites.addAll(result.products);

        hasNextPage.value = result.pagination.hasNext;
        hasPrevPage.value = result.pagination.hasPrev;
        totalItems.value = result.pagination.totalItems;
      }
    } catch (e) {
      print('Error loading favorites: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update search query and reload favorites with debouncing
  void updateSearchQuery(String query) {
    searchQuery.value = query;

    // Cancel previous timer
    _debounceTimer?.cancel();

    // Set new timer for debouncing (500ms delay)
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      loadFavorites(refresh: true);
    });
  }

  // Update sort and reload favorites
  void updateSort(String sort) {
    sortBy.value = sort;
    loadFavorites(refresh: true);
  }

  // Apply filters
  void applyFilters(Map<String, dynamic> filters) {
    selectedCategory.value = filters['category'] ?? '';
    minPrice.value = filters['minPrice']?.toDouble() ?? 0.0;
    maxPrice.value = filters['maxPrice']?.toDouble() ?? 0.0;

    // Check if any filters are active
    hasActiveFilters.value = selectedCategory.value.isNotEmpty ||
        minPrice.value > 0 ||
        maxPrice.value > 0;

    loadFavorites(refresh: true);
  }

  // Clear all filters
  void clearFilters() {
    selectedCategory.value = '';
    minPrice.value = 0.0;
    maxPrice.value = 0.0;
    hasActiveFilters.value = false;
    loadFavorites(refresh: true);
  }

  // Get current filters for dialog
  Map<String, dynamic> getCurrentFilters() {
    return {
      'category': selectedCategory.value,
      'minPrice': minPrice.value > 0 ? minPrice.value : null,
      'maxPrice': maxPrice.value > 0 ? maxPrice.value : null,
    };
  }

  // Load next page
  void loadNextPage() {
    if (hasNextPage.value && !isLoading.value) {
      currentPage.value++;
      loadFavorites();
    }
  }

  // Load previous page
  void loadPrevPage() {
    if (hasPrevPage.value && !isLoading.value && currentPage.value > 1) {
      currentPage.value--;
      loadFavorites();
    }
  }

  // Refresh favorites
  Future<void> refreshFavorites() async {
    await loadFavorites(refresh: true);
  }

  // Remove from favorites
  Future<void> removeFromFavorites(int productId) async {
    try {
      // Call API to remove from favorites
      // For now, just refresh the list
      await refreshFavorites();
    } catch (e) {
      print('Error removing from favorites: $e');
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}
