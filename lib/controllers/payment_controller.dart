import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/order_request_model.dart';
import '../services/transaction_service.dart';
import '../controllers/cart_controller.dart';
import '../controllers/address_controller.dart';
import '../routes/app_pages.dart';

class PaymentController extends GetxController {
  final TransactionService _transactionService = Get.find<TransactionService>();
  final CartController _cartController = Get.find<CartController>();
  final AddressController _addressController = Get.find<AddressController>();

  final RxBool isCreatingOrder = false.obs;
  final RxString error = ''.obs;

  Future<bool> createOrder({
    required int selectedPaymentMethodId,
    String? notes,
  }) async {
    try {
      isCreatingOrder.value = true;
      error.value = '';

      // Validasi alamat yang dipilih
      if (_addressController.selectedAddressId.value == -1) {
        error.value = 'Silakan pilih alamat pengiriman terlebih dahulu';
        return false;
      }

      // Buat request order
      final orderRequest = OrderRequestModel(
        addressId: _addressController.selectedAddressId.value,
        paymentMethodId: selectedPaymentMethodId,
        couponCode: _cartController.couponCode.value.isNotEmpty
            ? _cartController.couponCode.value
            : null,
        notes: notes,
      );

      print(
          'Creating order with request: ${orderRequest.toJson()}'); // Debug print

      // Panggil API untuk membuat order
      final orderResponse = await _transactionService.createOrder(orderRequest);

      print(
          'Order created successfully: ${orderResponse.orderId}'); // Debug print

      // Tampilkan notifikasi sukses
      Get.snackbar(
        'Berhasil',
        'Pesanan berhasil dibuat',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.check_circle, color: Colors.green),
      );

      // Navigasi ke halaman detail transaksi
      Get.offAllNamed(
        Routes.TRANSACTION_DETAIL,
        arguments: {'orderId': orderResponse.orderId},
      );

      return true;
    } catch (e) {
      print('Error creating order: $e'); // Debug print
      error.value = e.toString();

      // Tampilkan notifikasi error
      Get.snackbar(
        'Gagal',
        'Gagal membuat pesanan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.red),
      );

      return false;
    } finally {
      isCreatingOrder.value = false;
    }
  }
}
