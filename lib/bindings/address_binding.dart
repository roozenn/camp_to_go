import 'package:get/get.dart';
import '../controllers/address_controller.dart';
import '../services/address_service.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressService>(() => AddressService());
    Get.lazyPut<AddressController>(() => AddressController());
  }
}
