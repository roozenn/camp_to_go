import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../models/product_list_model.dart';
import '../widgets/filter_dialog.dart';
import '../widgets/main_bottom_nav.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavoriteController>();

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
                if (controller.isLoading.value &&
                    controller.favorites.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.favorites.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Belum ada produk favorit',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tambahkan produk ke favorit untuk melihatnya di sini',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: controller.refreshFavorites,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.625,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: controller.favorites.length,
                            itemBuilder: (context, index) {
                              final product = controller.favorites[index];
                              return _buildProductCard(
                                  product: product, controller: controller);
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
  final FavoriteController controller;

  const SearchAndFilterBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.offAllNamed('/account'),
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
              hintText: 'Cari produk favorit...',
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
                        showCategoryFilter:
                            true, // Show category filter for favorites
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

Widget _buildProductCard({
  required ProductItemModel product,
  required FavoriteController controller,
}) {
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
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/product-detail',
                          arguments: {'productId': product.id});
                    },
                    child: Image.network(
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
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/product-detail',
                      arguments: {'productId': product.id});
                },
                child: Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
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
