import 'package:get/get.dart';
import 'package:camp_to_go/models/product_detail_model.dart';
import 'package:camp_to_go/services/api_service.dart';

class ProductDetailState {
  final bool isLoading;
  final String? error;
  final ProductDetailModel? product;
  final List<ProductDetailModel> recommendedProducts;

  ProductDetailState({
    this.isLoading = false,
    this.error,
    this.product,
    this.recommendedProducts = const [],
  });

  ProductDetailState copyWith({
    bool? isLoading,
    String? error,
    ProductDetailModel? product,
    List<ProductDetailModel>? recommendedProducts,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      product: product ?? this.product,
      recommendedProducts: recommendedProducts ?? this.recommendedProducts,
    );
  }
}

class ProductDetailController extends GetxController {
  final _state = Rx<ProductDetailState>(ProductDetailState());
  ProductDetailState get state => _state.value;

  final ApiService _apiService = Get.find<ApiService>();
  final Rx<ProductDetailModel?> product = Rx<ProductDetailModel?>(null);
  final RxList<ProductDetailModel> recommendedProducts =
      <ProductDetailModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> loadProductDetail(int productId) async {
    if (productId <= 0) {
      _state.value = _state.value.copyWith(
        isLoading: false,
        error: 'ID produk tidak valid',
      );
      return;
    }

    _state.value = _state.value.copyWith(isLoading: true, error: null);

    try {
      final product = await _apiService.getProductDetail(productId);
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
        error: 'Gagal memuat data produk: ${e.toString()}',
      );
    }
  }

  Future<void> refreshData(int productId) async {
    await loadProductDetail(productId);
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
}
