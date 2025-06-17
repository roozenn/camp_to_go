import 'package:get/get.dart';
import 'package:camp_to_go/models/product_detail_model.dart';
import 'package:camp_to_go/services/api_service.dart';
import 'package:camp_to_go/services/product_service.dart';
import 'package:camp_to_go/services/cart_service.dart';
import 'package:flutter/material.dart';

class ProductDetailState {
  final bool isLoading;
  final String? error;
  final ProductDetailModel? product;
  final List<ProductDetailModel> recommendedProducts;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;

  ProductDetailState({
    this.isLoading = false,
    this.error,
    this.product,
    this.recommendedProducts = const [],
    this.selectedStartDate,
    this.selectedEndDate,
  });

  ProductDetailState copyWith({
    bool? isLoading,
    String? error,
    ProductDetailModel? product,
    List<ProductDetailModel>? recommendedProducts,
    DateTime? selectedStartDate,
    DateTime? selectedEndDate,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      product: product ?? this.product,
      recommendedProducts: recommendedProducts ?? this.recommendedProducts,
      selectedStartDate: selectedStartDate ?? this.selectedStartDate,
      selectedEndDate: selectedEndDate ?? this.selectedEndDate,
    );
  }
}

class ProductDetailController extends GetxController {
  final ProductService _productService = Get.find<ProductService>();
  final CartService _cartService = Get.find<CartService>();

  final _state = ProductDetailState().obs;
  ProductDetailState get state => _state.value;

  final ApiService _apiService = Get.find<ApiService>();

  final Rx<ProductDetailModel?> product = Rx<ProductDetailModel?>(null);
  final RxList<ProductDetailModel> recommendedProducts =
      <ProductDetailModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> loadProductDetail(int productId) async {
    _state.value = _state.value.copyWith(isLoading: true, error: null);
    try {
      final product = await _productService.getProductDetail(productId);
      _state.value = _state.value.copyWith(
        isLoading: false,
        product: product,
      );

      // Load recommended products separately to prevent main product from failing
      try {
        final recommendedProducts = await _apiService.getRecommendedProducts();
        _state.value = _state.value.copyWith(
          recommendedProducts: recommendedProducts,
        );
      } catch (e) {
        print('Error loading recommended products: $e');
        // Don't update error state, just log it
      }
    } catch (e) {
      _state.value = _state.value.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void updateSelectedDates(DateTime startDate, DateTime endDate) {
    _state.value = _state.value.copyWith(
      selectedStartDate: startDate,
      selectedEndDate: endDate,
    );
  }

  Future<void> addToCart({
    required DateTime startDate,
    required DateTime endDate,
    required int quantity,
  }) async {
    if (state.product == null) return;

    try {
      final success = await _cartService.addToCart(
        productId: state.product!.id,
        startDate: startDate,
        endDate: endDate,
        quantity: quantity,
      );

      if (success) {
        Get.snackbar(
          'Berhasil',
          'Produk berhasil ditambahkan ke keranjang',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Gagal',
          'Gagal menambahkan produk ke keranjang',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat menambahkan ke keranjang',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void refreshData(int productId) {
    loadProductDetail(productId);
  }

  Future<void> fetchProductDetail(int productId) async {
    try {
      _state.value = _state.value.copyWith(isLoading: true, error: null);
      print('=== DEBUG: Mencoba mengambil detail produk ===');
      final result = await _apiService.getProductDetail(productId);
      print('=== DEBUG: Hasil detail produk ===');
      print(result);
      if (result != null) {
        _state.value = _state.value.copyWith(
          isLoading: false,
          product: result,
        );
        print('=== DEBUG: Jumlah review ===');
        print(result.reviews.length);
        print('=== DEBUG: Data review ===');
        print(result.reviews);
      }
    } catch (e) {
      print('=== DEBUG: Error ===');
      print(e);
      _state.value = _state.value.copyWith(
        isLoading: false,
        error: 'Gagal memuat data produk: ${e.toString()}',
      );
    }
  }

  Future<void> toggleFavorite() async {
    if (state.product == null) return;

    try {
      await _apiService.toggleFavorite(
        state.product!.id,
        state.product!.isFavorited,
      );

      // Update state
      final updatedProduct = ProductDetailModel(
        id: state.product!.id,
        name: state.product!.name,
        description: state.product!.description,
        pricePerDay: state.product!.pricePerDay,
        originalPrice: state.product!.originalPrice,
        discountPercentage: state.product!.discountPercentage,
        depositAmount: state.product!.depositAmount,
        rating: state.product!.rating,
        reviewCount: state.product!.reviewCount,
        stockQuantity: state.product!.stockQuantity,
        category: state.product!.category,
        images: state.product!.images,
        isFavorited: !state.product!.isFavorited,
        reviews: state.product!.reviews,
      );
      _state.value = _state.value.copyWith(product: updatedProduct);

      // Tampilkan snackbar
      Get.snackbar(
        'Berhasil',
        updatedProduct.isFavorited
            ? 'Produk berhasil ditambahkan ke favorit'
            : 'Produk berhasil dihapus dari favorit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat mengubah status favorit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
