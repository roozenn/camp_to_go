import 'package:get/get.dart';
import '../controllers/listing_controller.dart';

class ListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListingController>(() => ListingController());
  }
}
