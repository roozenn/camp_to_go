import 'package:get/get.dart';
import 'package:camp_to_go/screen/home-page.dart';
import 'package:camp_to_go/screen/cart-page-gpt.dart';
import 'package:camp_to_go/screen/transaction-page.dart';
import 'package:camp_to_go/screen/transaction_detail_page.dart';
import 'package:camp_to_go/screen/akun-page.dart';
import 'package:camp_to_go/screen/profile-page.dart';
import 'package:camp_to_go/screen/change-password-page.dart';
import 'package:camp_to_go/screen/product-detail-page.dart';
import 'package:camp_to_go/screen/login-screen.dart';
import 'package:camp_to_go/screen/regist-page.dart';
import 'package:camp_to_go/screen/forgot-password-page.dart';
import 'package:camp_to_go/screen/verify-otp-page.dart';
import 'package:camp_to_go/screen/reset-password-page.dart';
import 'package:camp_to_go/screen/address-list-screen.dart';
import 'package:camp_to_go/screen/payment-page.dart';
import 'package:camp_to_go/screen/search-page.dart';
import 'package:camp_to_go/screen/listing-page.dart';
import 'package:camp_to_go/screen/favorite-page.dart';
import 'package:camp_to_go/bindings/home_binding.dart' as bindings;
import 'package:camp_to_go/bindings/product_detail_binding.dart';
import 'package:camp_to_go/bindings/transaction_binding.dart';
import 'package:camp_to_go/bindings/profile_binding.dart';
import 'package:camp_to_go/bindings/search_binding.dart';
import 'package:camp_to_go/bindings/listing_binding.dart';
import 'package:camp_to_go/bindings/favorite_binding.dart';
import 'package:camp_to_go/bindings/registration_binding.dart';
import 'package:camp_to_go/bindings/login_binding.dart';
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
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTRATION,
      page: () => const RegistrationPage(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.VERIFY_OTP,
      page: () => const VerifyOtpPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.RESET_PASSWORD,
      page: () => const ResetPasswordPage(),
      binding: LoginBinding(),
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
      name: Routes.TRANSACTION_DETAIL,
      page: () {
        final args = Get.arguments;
        if (args == null || !(args is Map<String, dynamic>)) {
          return const TransactionDetailPage(orderId: 0);
        }
        final orderId = args['orderId'];
        return TransactionDetailPage(orderId: orderId ?? 0);
      },
      binding: TransactionBinding(),
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
    GetPage(
      name: Routes.SEARCH,
      page: () => const SearchPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.LISTING,
      page: () => const ProductListPage(),
      binding: ListingBinding(),
      middlewares: [HomeMiddleware()],
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.CHANGE_PASSWORD,
      page: () => const ChangePasswordPage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.FAVORITE,
      page: () => const FavoritePage(),
      binding: FavoriteBinding(),
      middlewares: [HomeMiddleware()],
    ),
  ];
}
