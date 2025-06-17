import 'package:get/get.dart';
import 'package:camp_to_go/screen/home-page.dart';
import 'package:camp_to_go/screen/cart-page-gpt.dart';
import 'package:camp_to_go/screen/transaction-page.dart';
import 'package:camp_to_go/screen/akun-page.dart';
import 'package:camp_to_go/screen/product-detail-page.dart';
import 'package:camp_to_go/screen/login-screen.dart';
import 'package:camp_to_go/screen/address-list-screen.dart';
import 'package:camp_to_go/screen/payment-page.dart';
import 'package:camp_to_go/bindings/home_binding.dart' as bindings;
import 'package:camp_to_go/bindings/product_detail_binding.dart';
import 'package:camp_to_go/middleware/home_middleware.dart';
import '../bindings/address_binding.dart';
import '../bindings/payment_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: bindings.HomeBinding(),
      middlewares: [HomeMiddleware()],
    ),
    GetPage(
      name: Routes.CART,
      page: () => CartPage(),
      binding: bindings.HomeBinding(),
      middlewares: [HomeMiddleware()],
    ),
    GetPage(
      name: Routes.TRANSACTION,
      page: () => TransaksiPage(),
      binding: bindings.HomeBinding(),
      middlewares: [HomeMiddleware()],
    ),
    GetPage(
      name: Routes.ACCOUNT,
      page: () => AkunPage(),
      binding: bindings.HomeBinding(),
      middlewares: [HomeMiddleware()],
    ),
    GetPage(
      name: Routes.PRODUCT_DETAIL,
      page: () {
        print('Route arguments: ${Get.arguments}'); // Debug print
        final args = Get.arguments;
        if (args == null || !(args is Map<String, dynamic>)) {
          print('Invalid arguments, using default ID'); // Debug print
          return const ProductDetailPage(productId: 1);
        }
        final productId = args['productId'];
        print('Product ID from route: $productId'); // Debug print
        return ProductDetailPage(productId: productId ?? 1);
      },
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: Routes.ADDRESS_LIST,
      page: () => const AddressListScreen(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT,
      page: () => const PembayaranPage(),
      binding: PaymentBinding(),
    ),
  ];
}
