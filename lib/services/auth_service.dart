import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import 'token_service.dart';

class AuthService {
  // Menggunakan port yang sama dengan ApiService
  static const int API_PORT = 8000;
  final String baseUrl = 'http://localhost:$API_PORT';

  // Headers untuk mengatasi CORS
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: _headers,
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));

        // Jika login berhasil, simpan token
        if (loginResponse.success && loginResponse.data != null) {
          await TokenService.to.saveToken(
            loginResponse.data!.accessToken,
            loginResponse.data!.tokenType,
          );
        }

        return loginResponse;
      } else {
        throw Exception('Login gagal: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<void> logout() async {
    try {
      // Ambil header auth
      final authHeaders = TokenService.to.getAuthHeader();
      if (authHeaders.isEmpty) return;

      // Panggil endpoint logout
      await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {..._headers, ...authHeaders},
      );
    } catch (e) {
      print('Error during logout: $e');
    } finally {
      // Hapus token dari storage
      await TokenService.to.clearToken();
    }
  }
}
