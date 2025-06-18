import 'package:get/get.dart';
import '../models/profile_model.dart';
import '../services/profile_service.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService = Get.find<ProfileService>();

  final Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

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
}
