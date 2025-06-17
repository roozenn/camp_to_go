import 'package:get/get.dart';
import '../services/transaction_service.dart';

class TransactionDetailController extends GetxController {
  final TransactionService _transactionService = Get.find<TransactionService>();

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final Rx<Map<String, dynamic>?> transactionDetail =
      Rx<Map<String, dynamic>?>(null);

  Future<void> loadTransactionDetail(int orderId) async {
    try {
      isLoading.value = true;
      error.value = '';
      transactionDetail.value =
          await _transactionService.getTransactionDetail(orderId);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
