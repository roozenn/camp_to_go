import 'package:get/get.dart';
import 'package:camp_to_go/controllers/product_detail_controller.dart';
import 'package:camp_to_go/services/api_service.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Pastikan ApiService sudah tersedia
    if (!Get.isRegistered<ApiService>()) {
      Get.put(ApiService());
    }

    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
  }
}
