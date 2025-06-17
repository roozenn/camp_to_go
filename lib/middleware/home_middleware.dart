import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Pastikan HomeController sudah diinisialisasi
    if (!Get.isRegistered<HomeController>()) {
      return null;
    }

    // Update index berdasarkan route
    final controller = Get.find<HomeController>();
    controller.setIndexFromRoute();

    return null;
  }
}
