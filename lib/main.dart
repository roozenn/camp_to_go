import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/app_pages.dart';
import 'services/token_service.dart';
import 'services/api_service.dart';
import 'services/cart_service.dart';
import 'services/favorite_service.dart';
import 'services/transaction_service.dart';
import 'controllers/cart_controller.dart';
import 'controllers/auth_controller.dart';
import 'theme-colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Inisialisasi services
  await Get.putAsync(() => TokenService(prefs).init());
  await Get.putAsync(() => ApiService().init());
  await Get.putAsync(() => CartService().init());
  await Get.putAsync(() => FavoriteService().init());
  Get.put(TransactionService());

  // Inisialisasi controllers
  Get.put(CartController());
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CAMPtoGo',
      theme: buildLightTheme(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
    );
  }
}
