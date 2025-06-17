import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/cart_model.dart';
import '../theme-colors.dart';
import '../services/favorite_service.dart';
import '../routes/app_pages.dart';
import '../widgets/main_bottom_nav.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.find<CartController>();
  final FavoriteService favoriteService = Get.find<FavoriteService>();
  final TextEditingController _couponController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cartController.getCart();
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  Future<void> _toggleFavorite(CartItem item) async {
    try {
      bool success;
      if (item.isFavorited) {
        success = await favoriteService.removeFromFavorites(item.product.id);
        if (success) {
          Get.snackbar(
            'Berhasil',
            'Produk berhasil dihapus dari favorit',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      } else {
        success = await favoriteService.addToFavorites(item.product.id);
        if (success) {
          Get.snackbar(
            'Berhasil',
            'Produk berhasil ditambahkan ke favorit',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      }

      if (success) {
        // Refresh cart untuk memperbarui status favorit
        await cartController.getCart();
      } else {
        Get.snackbar(
          'Gagal',
          'Gagal mengubah status favorit',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _applyCoupon() async {
    if (_couponController.text.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Silakan masukkan kode kupon',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final isValid =
          await cartController.validateCoupon(_couponController.text);
      if (isValid) {
        Get.snackbar(
          'Berhasil',
          'Kupon berhasil diterapkan',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Gagal',
          cartController.error.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Gagal menerapkan kupon: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CAMPtoGoColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Keranjang',
          style: TextStyle(
              color: CAMPtoGoColors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.headset_mic_outlined, color: CAMPtoGoColors.black),
            onPressed: () {},
            padding: const EdgeInsets.only(right: 20),
          ),
        ],
      ),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cartController.cartItems.isEmpty) {
          return Center(
            child: Text(
              'Keranjang kosong',
              style: TextStyle(color: CAMPtoGoColors.darkGrey),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const SizedBox(height: 12),
                  ...cartController.cartItems.map((item) => CartItemCard(
                        item: item,
                        onDelete: () => cartController.removeFromCart(item.id),
                        onFavorite: () => _toggleFavorite(item),
                      )),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: cartController.discountAmount.value > 0
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CAMPtoGoColors.mediumGrey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.local_offer_outlined,
                                      color: CAMPtoGoColors.primaryGreen,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Kupon: ${cartController.couponCode.value}',
                                      style: TextStyle(
                                        color: CAMPtoGoColors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : TextField(
                                controller: _couponController,
                                decoration: InputDecoration(
                                  hintText: 'Masukan Kode Kupon',
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              cartController.discountAmount.value > 0
                                  ? CAMPtoGoColors.error
                                  : CAMPtoGoColors.primaryGreen,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: cartController.discountAmount.value > 0
                            ? () {
                                cartController.clearCoupon();
                                _couponController.clear();
                                Get.snackbar(
                                  'Berhasil',
                                  'Kupon berhasil dihapus',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              }
                            : _applyCoupon,
                        child: Text(
                          cartController.discountAmount.value > 0
                              ? 'Hapus'
                              : 'Terapkan',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CAMPtoGoColors.lightGrey,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: CAMPtoGoColors.mediumGrey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CostRow(
                          label:
                              'Biaya Sewa Barang (${cartController.cartItems.length})',
                          value: cartController.formatCurrency(
                              cartController.cartSummary.value?.totalRental ??
                                  0),
                        ),
                        const SizedBox(height: 8),
                        CostRow(
                          label: 'Deposit (${cartController.cartItems.length})',
                          value: cartController.formatCurrency(
                              cartController.cartSummary.value?.totalDeposit ??
                                  0),
                        ),
                        if (cartController.discountAmount.value > 0) ...[
                          const SizedBox(height: 8),
                          CostRow(
                            label: 'Diskon',
                            value:
                                '-${cartController.formatCurrency(cartController.discountAmount.value)}',
                          ),
                        ],
                        const Divider(height: 24),
                        CostRow(
                          label: 'Total Biaya',
                          value: cartController.formatCurrency(
                              (cartController.cartSummary.value?.totalAmount ??
                                      0) -
                                  cartController.discountAmount.value),
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: const MainBottomNav(),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2F4E3E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            Get.toNamed(Routes.ADDRESS_LIST);
          },
          child:
              const Text('Proses Pembayaran', style: TextStyle(fontSize: 16)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onDelete;
  final VoidCallback onFavorite;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: CAMPtoGoColors.mediumGrey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.product.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.startDate} - ${item.endDate}',
                  style:
                      TextStyle(color: CAMPtoGoColors.darkGrey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp ${item.subtotal.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: CAMPtoGoColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: onFavorite,
                icon: Icon(
                  item.isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: item.isFavorited
                      ? Colors.red
                      : CAMPtoGoColors.primaryGreen,
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete_outline, color: CAMPtoGoColors.error),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CostRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const CostRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = isBold
        ? TextStyle(fontWeight: FontWeight.bold, color: CAMPtoGoColors.black)
        : TextStyle(color: CAMPtoGoColors.darkGrey);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: textStyle), Text(value, style: textStyle)],
    );
  }
}
