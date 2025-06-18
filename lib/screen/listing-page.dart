/*
 * 1. Import Statements
 *    - flutter/material.dart
 * 
 * 2. Class Utama
 *    - ProductListPage (StatelessWidget)
 *      - build() method
 *        - Scaffold dengan backgroundColor putih
 *        - SafeArea dengan Column layout:
 *          a. SearchAndFilterBar
 *          b. GridView.builder untuk produk
 * 
 * 3. Widget Methods (Urutan Implementasi)
 *    a. SearchAndFilterBar [Line ~100]
 *       - Row layout
 *       - TextField untuk pencarian
 *       - IconButton untuk sort
 *       - IconButton untuk filter
 * 
 *    b. _buildProductCard() [Line ~150]
 *       - Card layout dengan border radius
 *       - Column layout dengan:
 *         - Image.network untuk gambar produk
 *         - Text untuk nama produk
 *         - Text untuk harga saat ini
 *         - Row untuk harga asli dan diskon
 * 
 * 4. Data Statis
 *    - List products dalam ProductListPage:
 *      - 6 item produk camping
 *      - Setiap produk memiliki:
 *        * imageUrl: URL gambar produk
 *        * productName: Nama produk
 *        * currentPrice: Harga sewa per hari
 *        * originalPrice: Harga asli per hari
 *        * discount: Persentase diskon
 * 
 * 5. Styling
 *    - GridView.builder:
 *      - crossAxisCount: 2
 *      - childAspectRatio: 0.625
 *      - crossAxisSpacing: 10
 *      - mainAxisSpacing: 10
 *    - Card:
 *      - BorderRadius: 12
 *      - Padding: 12
 *    - Text Styles:
 *      - Product Name: bold, 15px
 *      - Current Price: bold, 14px, color: 0xFF2F4E3E
 *      - Original Price: 12px, grey, line-through
 *      - Discount: 12px, bold, red
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/listing_controller.dart';
import '../models/product_list_model.dart';
import '../widgets/filter_dialog.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ListingController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SearchAndFilterBar(controller: controller),
            ),
            // Filter status indicator
            Obx(() {
              if (controller.hasActiveFilters.value) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.filter_alt,
                          size: 16, color: Color(0xFF2F4E3E)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Filter aktif: ${controller.selectedCategory.value.isNotEmpty ? controller.selectedCategory.value : ''}${controller.minPrice.value > 0 || controller.maxPrice.value > 0 ? ', harga ${controller.minPrice.value > 0 ? 'Rp${controller.minPrice.value.toStringAsFixed(0)}' : '0'} - ${controller.maxPrice.value > 0 ? 'Rp${controller.maxPrice.value.toStringAsFixed(0)}' : '∞'}' : ''}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF2F4E3E),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: controller.clearFilters,
                        child: const Text(
                          'Hapus',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.products.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.products.isEmpty) {
                  return const Center(
                    child: Text(
                      'Tidak ada produk ditemukan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: controller.refreshProducts,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.625,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: controller.products.length,
                            itemBuilder: (context, index) {
                              final product = controller.products[index];
                              return _buildProductCard(product: product);
                            },
                          ),
                        ),
                      ),
                      // Pagination controls
                      if (controller.hasNextPage.value ||
                          controller.hasPrevPage.value)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (controller.hasPrevPage.value)
                                ElevatedButton(
                                  onPressed: controller.loadPrevPage,
                                  child: const Text('Sebelumnya'),
                                )
                              else
                                const SizedBox.shrink(),
                              Text('Halaman ${controller.currentPage.value}'),
                              if (controller.hasNextPage.value)
                                ElevatedButton(
                                  onPressed: controller.loadNextPage,
                                  child: const Text('Selanjutnya'),
                                )
                              else
                                const SizedBox.shrink(),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchAndFilterBar extends StatelessWidget {
  final ListingController controller;

  const SearchAndFilterBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            onChanged: controller.updateSearchQuery,
            onSubmitted: controller.updateSearchQuery,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Cari produk...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        const SizedBox(width: 8),
        PopupMenuButton<String>(
          icon: const Icon(Icons.sort),
          onSelected: controller.updateSort,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'price_asc',
              child: Text('Harga: Rendah ke Tinggi'),
            ),
            const PopupMenuItem(
              value: 'price_desc',
              child: Text('Harga: Tinggi ke Rendah'),
            ),
            const PopupMenuItem(
              value: 'rating',
              child: Text('Rating Tertinggi'),
            ),
            const PopupMenuItem(
              value: 'popular',
              child: Text('Terpopuler'),
            ),
          ],
        ),
        Obx(() => Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: controller.hasActiveFilters.value
                        ? const Color(0xFF2F4E3E)
                        : null,
                  ),
                  onPressed: () {
                    Get.dialog(
                      FilterDialog(
                        onApplyFilter: controller.applyFilters,
                        currentFilters: controller.getCurrentFilters(),
                      ),
                    );
                  },
                ),
                if (controller.hasActiveFilters.value)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2F4E3E),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            )),
      ],
    );
  }
}

Widget _buildProductCard({required ProductItemModel product}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    product.imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        product.isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorited ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        // TODO: Implement favorite toggle
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${product.reviewCount})',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Rp${product.pricePerDay.toStringAsFixed(0)}/hari',
                style: const TextStyle(
                  color: Color(0xFF2F4E3E),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    'Rp${product.originalPrice.toStringAsFixed(0)}/hari',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Spacer(),
                  Text(
                    '${product.discountPercentage}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
