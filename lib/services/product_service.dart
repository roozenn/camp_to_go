import 'package:get/get.dart';
import 'package:camp_to_go/services/api_service.dart';
import 'package:camp_to_go/models/product_detail_model.dart';

class ProductService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  Future<ProductDetailModel> getProductDetail(int productId) async {
    try {
      final response = await _apiService.get('/products/$productId');
      final product = ProductDetailModel.fromJson(response.data);

      // Get reviews data
      final reviewsResponse =
          await _apiService.get('/products/$productId/reviews');
      if (reviewsResponse.data['success'] == true) {
        final reviewsData = reviewsResponse.data['data'];
        final reviews = (reviewsData['reviews'] as List<dynamic>).map((review) {
          return ProductReviewModel.fromJson(review);
        }).toList();

        // Update product with reviews
        return ProductDetailModel(
          id: product.id,
          name: product.name,
          description: product.description,
          pricePerDay: product.pricePerDay,
          originalPrice: product.originalPrice,
          discountPercentage: product.discountPercentage,
          depositAmount: product.depositAmount,
          rating: product.rating,
          reviewCount: product.reviewCount,
          stockQuantity: product.stockQuantity,
          category: product.category,
          images: product.images,
          reviews: reviews,
          isFavorited: product.isFavorited,
        );
      }

      return product;
    } catch (e) {
      rethrow;
    }
  }
}
