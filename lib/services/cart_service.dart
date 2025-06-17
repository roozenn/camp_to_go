import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/cart_model.dart';
import 'token_service.dart';
import 'api_service.dart';

class CartService extends GetxService {
  static CartService get to => Get.find();

  final ApiService _apiService = Get.find<ApiService>();

  // Menggunakan port yang sama dengan ApiService
  static const int API_PORT = 8000;
  final String baseUrl = 'http://localhost:$API_PORT';

  // Headers untuk mengatasi CORS
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Inisialisasi service
  Future<CartService> init() async {
    return this;
  }

  // Mendapatkan header dengan token
  Map<String, String> _getAuthHeaders() {
    return {
      ..._headers,
      ...TokenService.to.getAuthHeader(),
    };
  }

  // Mendapatkan daftar item di cart
  Future<CartResponse> getCart() async {
    try {
      final response = await _apiService.get('/cart');
      print('Cart Response: ${response.data}'); // Debug print
      if (response.data['success'] == true) {
        final cartResponse = CartResponse.fromJson(response.data['data']);
        print(
            'Cart Items: ${cartResponse.items.map((item) => 'ID: ${item.id}, IsFavorited: ${item.isFavorited}').join('\n')}'); // Debug print
        return cartResponse;
      } else {
        throw Exception(
            response.data['message'] ?? 'Gagal mendapatkan data cart');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Menambahkan item ke cart
  Future<bool> addToCart({
    required int productId,
    required DateTime startDate,
    required DateTime endDate,
    required int quantity,
  }) async {
    try {
      final response = await _apiService.post(
        '/cart',
        data: {
          'product_id': productId,
          'start_date': startDate.toIso8601String().split('T')[0],
          'end_date': endDate.toIso8601String().split('T')[0],
          'quantity': quantity,
        },
      );

      return response.data['success'] ?? false;
    } catch (e) {
      return false;
    }
  }

  // Mengupdate item di cart
  Future<void> updateCartItem({
    required int cartId,
    required String startDate,
    required String endDate,
    required int quantity,
  }) async {
    try {
      final response = await _apiService.put('/cart/$cartId', data: {
        'start_date': startDate,
        'end_date': endDate,
        'quantity': quantity,
      });
      if (response.data['success'] != true) {
        throw Exception(response.data['message'] ?? 'Gagal mengupdate cart');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Menghapus item dari cart
  Future<void> removeFromCart(int cartId) async {
    try {
      final response = await _apiService.delete('/cart/$cartId');
      if (response.data['success'] != true) {
        throw Exception(
            response.data['message'] ?? 'Gagal menghapus dari cart');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Validasi kupon
  Future<Map<String, dynamic>> validateCoupon(String couponCode) async {
    try {
      final response = await _apiService.post('/cart/validate-coupon', data: {
        'coupon_code': couponCode,
      });
      if (response.data['success'] != true) {
        throw Exception(response.data['message'] ?? 'Gagal validasi kupon');
      }
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateQuantity(String itemId, int quantity) async {
    try {
      await _apiService.put('/cart/$itemId', data: {
        'quantity': quantity,
      });
    } catch (e) {
      rethrow;
    }
  }
}
