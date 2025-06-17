import 'package:get/get.dart';
import 'api_service.dart';

class FavoriteService extends GetxService {
  static FavoriteService get to => Get.find();
  final ApiService _apiService = Get.find<ApiService>();

  // Inisialisasi service
  Future<FavoriteService> init() async {
    return this;
  }

  // Mendapatkan daftar favorit
  Future<List<dynamic>> getFavorites() async {
    try {
      final response = await _apiService.get('/favorites');
      if (response.data['success'] == true) {
        return response.data['data'];
      } else {
        throw Exception(
            response.data['message'] ?? 'Gagal mendapatkan data favorit');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Menambahkan ke favorit
  Future<bool> addToFavorites(int productId) async {
    try {
      final response = await _apiService.post('/favorites/$productId');
      return response.data['success'] ?? false;
    } catch (e) {
      return false;
    }
  }

  // Menghapus dari favorit
  Future<bool> removeFromFavorites(int productId) async {
    try {
      final response = await _apiService.delete('/favorites/$productId');
      return response.data['success'] ?? false;
    } catch (e) {
      return false;
    }
  }
}
