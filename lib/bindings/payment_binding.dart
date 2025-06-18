import 'package:get/get.dart';
import '../controllers/payment_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/address_controller.dart';
import '../services/payment_service.dart';
import '../services/cart_service.dart';
import '../services/address_service.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentService>(() => PaymentService());
    Get.lazyPut<CartService>(() => CartService());
    Get.lazyPut<AddressService>(() => AddressService());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<AddressController>(() => AddressController());
    Get.lazyPut<PaymentController>(() => PaymentController());
  }
}
