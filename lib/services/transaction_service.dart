import 'package:get/get.dart';
import 'api_service.dart';

class TransactionService {
  final ApiService _apiService = Get.find<ApiService>();

  Future<Map<String, dynamic>> getTransactionDetail(int orderId) async {
    try {
      final response = await _apiService.get('/orders/$orderId');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              responseData['message'] ?? 'Gagal mengambil detail transaksi');
        }
      } else {
        throw Exception(
            'Gagal mengambil detail transaksi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal mengambil detail transaksi: $e');
    }
  }
}
