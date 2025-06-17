import 'package:get/get.dart';
import '../models/payment_method_model.dart';
import 'api_service.dart';

class PaymentService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();
  final RxList<PaymentMethod> paymentMethods = <PaymentMethod>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  Future<void> getPaymentMethods() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _apiService.get('/payment-methods');

      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'];
        paymentMethods.value =
            data.map((json) => PaymentMethod.fromJson(json)).toList();
      } else {
        error.value = 'Gagal mengambil data metode pembayaran';
      }
    } catch (e) {
      error.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPaymentMethod({
    required String methodType,
    required String providerName,
    required String accountNumber,
    required String accountName,
    required bool isDefault,
  }) async {
    try {
      final response = await _apiService.post(
        '/payment-methods',
        data: {
          'method_type': methodType,
          'provider_name': providerName,
          'account_number': accountNumber,
          'account_name': accountName,
          'is_default': isDefault,
        },
      );

      if (response.data['success'] != true) {
        throw Exception(
            response.data['message'] ?? 'Gagal menambahkan metode pembayaran');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
