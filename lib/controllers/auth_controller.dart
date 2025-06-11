import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController extends GetxController {
  final String baseUrl = 'http://127.0.0.1:8000';
  var token = ''.obs;
  var isLoggedIn = false.obs;
  final String _tokenKey = 'auth_token';

  @override
  void onInit() {
    super.onInit();
    loadToken();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString(_tokenKey) ?? '';
    token.value = savedToken;
    isLoggedIn.value = savedToken.isNotEmpty;
  }

  Future<void> saveToken(String newToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, newToken);
    token.value = newToken;
    isLoggedIn.value = true;
  }

  Future<void> logout() async {
    try {
      // Panggil API logout
      final response = await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Hapus token dari local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);

      // Reset state
      token.value = '';
      isLoggedIn.value = false;

      // Navigate ke halaman login
      Get.offAllNamed('/login');
    } catch (e) {
      print('Error during logout: $e');
      // Tetap hapus token lokal meskipun API call gagal
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      token.value = '';
      isLoggedIn.value = false;
      Get.offAllNamed('/login');
    }
  }
}
