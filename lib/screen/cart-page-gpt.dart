import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/cart_model.dart';
import '../theme-colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    cartController.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CAMPtoGoColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
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

        if (cartController.error.isNotEmpty) {
          return Center(
            child: Text(
              'Terjadi kesalahan: ${cartController.error}',
              textAlign: TextAlign.center,
              style: TextStyle(color: CAMPtoGoColors.error),
            ),
          );
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
                  ...cartController.cartItems.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CartItemCard(
                          itemName: item.product.name,
                          price: cartController.formatCurrency(item.subtotal),
                          imageUrl: item.product.imageUrl,
                          startDate: item.startDate,
                          endDate: item.endDate,
                          onDelete: () =>
                              cartController.removeFromCart(item.id),
                        ),
                      )),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
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
                          backgroundColor: CAMPtoGoColors.primaryGreen,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Terapkan'),
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
                        const Divider(height: 24),
                        CostRow(
                          label: 'Total Biaya',
                          value: cartController.formatCurrency(
                              cartController.cartSummary.value?.totalAmount ??
                                  0),
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CAMPtoGoColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Bayar', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final String itemName;
  final String price;
  final String imageUrl;
  final String startDate;
  final String endDate;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.itemName,
    required this.price,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: CAMPtoGoColors.mediumGrey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
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
                  itemName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  '$startDate - $endDate',
                  style:
                      TextStyle(color: CAMPtoGoColors.darkGrey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
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
                onPressed: () {},
                icon: Icon(Icons.favorite_border,
                    color: CAMPtoGoColors.primaryGreen),
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
