import 'package:get/get.dart';
import '../services/payment_service.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentService>(() => PaymentService());
  }
}
