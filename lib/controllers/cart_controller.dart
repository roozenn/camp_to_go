import 'package:get/get.dart';
import '../models/cart_model.dart';
import '../services/cart_service.dart';

class CartController extends GetxController {
  final CartService _cartService = Get.find<CartService>();

  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final Rx<CartSummary?> cartSummary = Rx<CartSummary?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString couponCode = ''.obs;
  final RxDouble discountAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  Future<void> getCart() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _cartService.getCart();
      cartItems.value = response.items;
      cartSummary.value = response.summary;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateCartItem({
    required int cartId,
    required String startDate,
    required String endDate,
    required int quantity,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      await _cartService.updateCartItem(
        cartId: cartId,
        startDate: startDate,
        endDate: endDate,
        quantity: quantity,
      );
      await getCart(); // Refresh cart setelah update
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFromCart(int cartId) async {
    try {
      isLoading.value = true;
      error.value = '';

      await _cartService.removeFromCart(cartId);
      await getCart(); // Refresh cart setelah hapus
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> validateCoupon(String code) async {
    try {
      isLoading.value = true;
      error.value = '';

      final result = await _cartService.validateCoupon(code);
      if (result['valid'] == true) {
        couponCode.value = code;
        discountAmount.value = (result['discount_amount'] as num).toDouble();
      } else {
        error.value = result['message'] as String;
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void clearCoupon() {
    couponCode.value = '';
    discountAmount.value = 0.0;
  }

  String formatCurrency(double amount) {
    return 'Rp${amount.toStringAsFixed(0)}';
  }
}
