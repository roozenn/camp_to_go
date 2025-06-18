import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../services/profile_service.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileService>(() => ProfileService());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
