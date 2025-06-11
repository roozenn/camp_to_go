import 'package:get/get.dart';
import 'package:camp_to_go/controllers/product_detail_controller.dart';
import 'package:camp_to_go/services/cart_service.dart';
import 'package:camp_to_go/services/product_service.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartService());
    Get.lazyPut(() => ProductService());
    Get.lazyPut(() => ProductDetailController());
  }
}
