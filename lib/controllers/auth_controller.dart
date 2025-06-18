import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';
import '../models/forgot_password_request.dart';
import '../models/forgot_password_response.dart';
import '../models/verify_otp_request.dart';
import '../models/reset_password_request.dart';
import '../routes/app_pages.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  var token = ''.obs;
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
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

  Future<void> register(String fullName, String email, String password,
      String confirmPassword) async {
    try {
      isLoading.value = true;

      final request = RegisterRequest(
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      final response = await _authService.register(request);

      if (response.success) {
        Get.snackbar(
          'Sukses',
          'Registrasi berhasil! Silakan login.',
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
        );
        Get.offNamed(Routes.LOGIN);
      } else {
        Get.snackbar(
          'Error',
          response.message,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      isLoading.value = true;

      final request = ForgotPasswordRequest(email: email);
      final response = await _authService.forgotPassword(request);

      if (response.success) {
        Get.snackbar(
          'Sukses',
          response.message,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
        );
        Get.toNamed(Routes.VERIFY_OTP, arguments: {'email': email});
      } else {
        Get.snackbar(
          'Error',
          response.message,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    try {
      isLoading.value = true;

      final request = VerifyOtpRequest(email: email, otp: otp);
      final response = await _authService.verifyOtp(request);

      if (response.success) {
        Get.snackbar(
          'Sukses',
          response.message,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
        );
        Get.toNamed(Routes.RESET_PASSWORD,
            arguments: {'email': email, 'otp': otp});
      } else {
        Get.snackbar(
          'Error',
          response.message,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email, String otp, String newPassword,
      String confirmPassword) async {
    try {
      isLoading.value = true;

      final request = ResetPasswordRequest(
        email: email,
        otp: otp,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      final response = await _authService.resetPassword(request);

      if (response.success) {
        Get.snackbar(
          'Sukses',
          response.message,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
        );
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar(
          'Error',
          response.message,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print('Error during logout: $e');
      // Tetap logout meskipun API call gagal
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      token.value = '';
      isLoggedIn.value = false;
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
