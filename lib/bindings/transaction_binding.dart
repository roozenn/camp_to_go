import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';
import '../controllers/transaction_detail_controller.dart';
import '../services/transaction_service.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionService>(() => TransactionService());
    Get.lazyPut<TransactionController>(() => TransactionController());
    Get.lazyPut<TransactionDetailController>(
        () => TransactionDetailController());
  }
}
