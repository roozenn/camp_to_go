import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:camp_to_go/controllers/product_detail_controller.dart';
import 'package:camp_to_go/models/product_detail_model.dart';
import 'package:intl/intl.dart';
import 'package:camp_to_go/routes/routes.dart';
import 'package:camp_to_go/bindings/product_detail_binding.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();

    // Load data saat halaman dibuka
    controller.loadProductDetail(productId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.offAllNamed(Routes.HOME),
        ),
        title: Obx(() => Text(
              controller.state.product?.name ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            )),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.state.selectedStartDate == null ||
                      controller.state.selectedEndDate == null) {
                    Get.snackbar(
                      'Peringatan',
                      'Silakan pilih tanggal sewa terlebih dahulu',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  controller.addToCart(
                    startDate: controller.state.selectedStartDate!,
                    endDate: controller.state.selectedEndDate!,
                    quantity: 1,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2F4E3E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFF2F4E3E)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "+ Keranjang",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.state.selectedStartDate == null ||
                      controller.state.selectedEndDate == null) {
                    Get.snackbar(
                      'Peringatan',
                      'Silakan pilih tanggal sewa terlebih dahulu',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  // TODO: Implementasi logika sewa
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F4E3E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Sewa", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Obx(() {
        if (controller.state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.state.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.state.error ?? ''),
                ElevatedButton(
                  onPressed: () => controller.refreshData(productId),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        final product = controller.state.product;
        if (product == null) {
          return const Center(child: Text('Produk tidak ditemukan'));
        }

        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(height: 8),
              // Product Image Carousel
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterCarousel(
                  items: product.images.map((image) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(image.imageUrl),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 350,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Title
              Text(
                product.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Rating
              Row(
                children: [
                  ...List.generate(5, (index) {
                    if (index < product.rating.floor()) {
                      return const Icon(Icons.star,
                          color: Colors.amber, size: 20);
                    } else if (index < product.rating.ceil()) {
                      return const Icon(Icons.star_half,
                          color: Colors.amber, size: 20);
                    }
                    return const Icon(Icons.star_border,
                        color: Colors.amber, size: 20);
                  }),
                  const SizedBox(width: 8),
                  Text("${product.rating} (${product.reviews.length} Ulasan)"),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Rp${product.pricePerDay.toStringAsFixed(0)}/hari",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F4E3E),
                ),
              ),
              const SizedBox(height: 2),
              Text("Deposit : Rp${product.depositAmount.toStringAsFixed(0)}"),
              const SizedBox(height: 20),
              // Date Picker
              const Text(
                "Pilih Tanggal",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    initialDateRange:
                        controller.state.selectedStartDate != null &&
                                controller.state.selectedEndDate != null
                            ? DateTimeRange(
                                start: controller.state.selectedStartDate!,
                                end: controller.state.selectedEndDate!,
                              )
                            : null,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF2F4E3E),
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (picked != null) {
                    controller.updateSelectedDates(picked.start, picked.end);
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          if (controller.state.selectedStartDate == null ||
                              controller.state.selectedEndDate == null) {
                            return const Text("Pilih tanggal sewa");
                          }
                          return Text(
                            "${DateFormat('d MMMM yyyy').format(controller.state.selectedStartDate!)} - "
                            "${DateFormat('d MMMM yyyy').format(controller.state.selectedEndDate!)}",
                          );
                        }),
                      ),
                      const Icon(Icons.calendar_today, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Deskripsi
              const Text(
                "Deskripsi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: const TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 30),
              // Ulasan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Ulasan", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    "Lihat Semua",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F4E3E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ...List.generate(5, (index) {
                    if (index < product.rating.floor()) {
                      return const Icon(Icons.star,
                          color: Colors.amber, size: 18);
                    } else if (index < product.rating.ceil()) {
                      return const Icon(Icons.star_half,
                          color: Colors.amber, size: 18);
                    }
                    return const Icon(Icons.star_border,
                        color: Colors.amber, size: 18);
                  }),
                  const SizedBox(width: 8),
                  Text("${product.rating} (${product.reviews.length} Ulasan)"),
                ],
              ),
              const SizedBox(height: 12),
              if (product.reviews.isNotEmpty)
                ...product.reviews.map((review) => _buildReviewItem(review))
              else
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Memuat ulasan...'),
                  ),
                ),
              const SizedBox(height: 30),
              const Text(
                "Rekomendasi Untuk Kamu",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              if (controller.state.recommendedProducts.isNotEmpty)
                SizedBox(
                  height: 240,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: controller.state.recommendedProducts
                        .map((product) => _buildRecommendationCard(product))
                        .toList(),
                  ),
                )
              else
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Tidak ada produk rekomendasi saat ini'),
                  ),
                ),
              const SizedBox(height: 80),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildReviewItem(ProductReviewModel review) {
    print(
        'Building review item: ${review.userName} - ${review.comment}'); // Debug print
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: review.userProfilePicture.isNotEmpty
                    ? NetworkImage(review.userProfilePicture)
                    : null,
                child: review.userProfilePicture.isEmpty
                    ? const Icon(Icons.person)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          if (index < review.rating) {
                            return const Icon(Icons.star,
                                color: Colors.amber, size: 16);
                          }
                          return const Icon(Icons.star_border,
                              color: Colors.amber, size: 16);
                        }),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('dd MMM yyyy').format(review.createdAt),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              review.comment,
              style: const TextStyle(fontSize: 14),
            ),
          ],
          if (review.images.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: review.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(review.images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(ProductDetailModel product) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          print('Tapped product with ID: ${product.id}');
          if (Get.isRegistered<ProductDetailController>()) {
            Get.delete<ProductDetailController>();
          }
          Get.toNamed(
            Routes.PRODUCT_DETAIL,
            arguments: {'productId': product.id},
            preventDuplicates: false,
          );
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.images.first.imageUrl,
                      height: 100,
                      width: 116,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Rp${product.pricePerDay.toStringAsFixed(0)}/hari",
                      style: const TextStyle(
                        color: Color(0xFF2F4E3E),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rp${product.originalPrice.toStringAsFixed(0)}/hari",
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
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
        ),
      ),
    );
  }
}
