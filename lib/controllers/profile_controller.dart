import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../services/profile_service.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService = Get.find<ProfileService>();

  final Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isChangingPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final profileData = await _profileService.getProfile();

      if (profileData != null) {
        profile.value = profileData;
      } else {
        errorMessage.value = 'Gagal memuat data profil';
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
      print('Error in fetchProfile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void refreshProfile() {
    fetchProfile();
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      isChangingPassword.value = true;

      final result = await _profileService.changePassword(
        currentPassword,
        newPassword,
        confirmPassword,
      );

      if (result['success'] == true) {
        Get.snackbar(
          'Berhasil',
          result['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        Get.back(); // Kembali ke halaman sebelumnya
      } else {
        Get.snackbar(
          'Gagal',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat mengubah password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      print('Error in changePassword: $e');
    } finally {
      isChangingPassword.value = false;
    }
  }
}
