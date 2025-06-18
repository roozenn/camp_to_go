import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/profile_model.dart';
import 'token_service.dart';

class ProfileService extends GetxService {
  late Dio _dio;
  final TokenService _tokenService = Get.find<TokenService>();

  Future<ProfileService> init() async {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:8000',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _tokenService.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.type == DioExceptionType.connectionTimeout) {
          print('Koneksi timeout: ${e.message}');
        }
        if (e.response?.statusCode == 401) {
          await _tokenService.clearToken();
          Get.offAllNamed('/login');
        }
        return handler.next(e);
      },
    ));

    return this;
  }

  Future<ProfileModel?> getProfile() async {
    try {
      print('Fetching user profile...'); // Debug print
      final response = await _dio.get('/profile');

      print('Profile Response: ${response.data}'); // Debug print

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          return ProfileModel.fromJson(data['data']);
        }
      }
      return null;
    } catch (e) {
      print('Error getting profile: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      print('Changing password...'); // Debug print
      final response = await _dio.put('/profile/change-password', data: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      });

      print('Change Password Response: ${response.data}'); // Debug print

      if (response.statusCode == 200) {
        final data = response.data;
        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? 'Password berhasil diubah',
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Gagal mengubah password',
        };
      }
    } catch (e) {
      print('Error changing password: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan saat mengubah password',
      };
    }
  }
}
