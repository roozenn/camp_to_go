import 'package:camp_to_go/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/transaction_model.dart';
import '../services/token_service.dart';

class TransactionController extends GetxController {
  final String baseUrl = 'http://127.0.0.1:8000';
  var transactions = <TransactionModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  late AuthController authController;
  final TokenService _tokenService = Get.find<TokenService>();

  @override
  void onInit() {
    super.onInit();
    authController = Get.find<AuthController>();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      error.value = '';

      // Tunggu token dimuat
      await authController.loadToken();

      if (!_tokenService.isLoggedIn) {
        error.value = 'Anda belum login';
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/orders'),
        headers: _tokenService.getAuthHeader(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response data: $data'); // Debug print

        if (data['success'] == true) {
          // Pastikan data['data'] adalah List
          if (data['data'] is List) {
            transactions.value = (data['data'] as List)
                .map((item) => TransactionModel.fromJson(item))
                .toList();
          } else if (data['data'] is Map) {
            // Jika data['data'] adalah Map, coba ambil array orders
            final orders = data['data']['orders'] as List?;
            if (orders != null) {
              transactions.value = orders
                  .map((item) => TransactionModel.fromJson(item))
                  .toList();
            } else {
              error.value = 'Format data tidak sesuai';
            }
          } else {
            error.value = 'Format data tidak sesuai';
          }
        } else {
          error.value = data['message'] ?? 'Terjadi kesalahan';
        }
      } else {
        error.value = 'Gagal mengambil data transaksi';
      }
    } catch (e) {
      print('Error details: $e'); // Debug print
      error.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  String getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Dalam Proses';
      case 'processing':
        return 'Dalam Penyewaan';
      case 'completed':
        return 'Selesai';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return status;
    }
  }

  String formatDate(String date) {
    if (date.isEmpty) return '';
    final DateTime dateTime = DateTime.parse(date);
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return '${dateTime.day} ${months[dateTime.month - 1]}, ${dateTime.year}';
  }

  String formatCurrency(double amount) {
    return 'Rp ${amount.toStringAsFixed(0)}';
  }

  Future<bool> returnItem(String orderId) async {
    try {
      // Tunggu token dimuat
      await authController.loadToken();

      if (!_tokenService.isLoggedIn) {
        error.value = 'Anda belum login';
        return false;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/orders/$orderId/return'),
        headers: _tokenService.getAuthHeader(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          // Refresh data transaksi setelah pengembalian berhasil
          await fetchTransactions();
          return true;
        } else {
          error.value = data['message'] ?? 'Gagal mengembalikan barang';
          return false;
        }
      } else {
        error.value = 'Gagal mengembalikan barang';
        return false;
      }
    } catch (e) {
      print('Error returning item: $e');
      error.value = 'Terjadi kesalahan: $e';
      return false;
    }
  }
}
