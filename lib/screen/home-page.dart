/*
 * STRUKTUR KODE PROGRAM - Home Page
 * 
 * 1. Import Statements
 *    - flutter/material.dart
 *    - flutter_carousel_widget/flutter_carousel_widget.dart
 *    - camp_to_go/screen/my-home.dart
 *    - font_awesome_flutter/font_awesome_flutter.dart
 * 
 * 2. Class Utama
 *    - HomePage (StatefulWidget)
 *      - createState() method
 *        - _HomePageState
 * 
 * 3. Widget Methods (Urutan Implementasi)
 *    a. _buildHeader() [Line ~100]
 *       - Search bar
 *       - Icon notifikasi
 *       - Icon headset
 * 
 *    b. _buildLocationSelector() [Line ~130]
 *       - Text kota
 *       - Icon dropdown
 * 
 *    c. _buildPromoCarousel() [Line ~140]
 *       - CarouselSlider
 *       - List promos
 *       - Stack untuk overlay text
 * 
 *    d. _buildCategoryMenu() [Line ~200]
 *       - Row kategori
 *       - CircleAvatar icons
 * 
 *    e. _buildProductSection() [Line ~250]
 *       - Column layout
 *       - ListView.builder horizontal
 *       - Product cards
 * 
 *    f. _buildPopularBanner() [Line ~350]
 *       - Stack layout
 *       - Image background
 *       - Positioned text
 * 
 *    g. _buildProductCard() [Line ~380]
 *       - Card layout
 *       - Image
 *       - Product details
 * 
 * 4. Class Pendukung
 *    - Product [Line ~450]
 *      - Properties: name, price, imageUrl, originalPrice
 * 
 * 5. Data Statis
 *    - List promos dalam _buildPromoCarousel()
 *    - List categories dalam _buildCategoryMenu()
 *    - List products dalam _buildProductSection()
 *    - List products dalam GridView
 */

import 'package:camp_to_go/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:camp_to_go/screen/cart-page-gpt.dart';
import 'package:camp_to_go/screen/transaction-page.dart';
import 'package:camp_to_go/screen/akun-page.dart';
import 'package:camp_to_go/screen/product-detail-page.dart';
import 'package:camp_to_go/services/api_service.dart';
import 'package:camp_to_go/models/banner_model.dart';
import 'package:camp_to_go/models/category_model.dart';
import 'package:camp_to_go/models/product_model.dart';
import 'package:get/get.dart';
import 'package:camp_to_go/controllers/home_controller.dart';
import 'package:camp_to_go/routes/app_pages.dart';
import 'package:camp_to_go/widgets/main_bottom_nav.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      body: Obx(() => controller.state.value?.isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : controller.pages[controller.selectedIndex.value]),
      bottomNavigationBar: const MainBottomNav(),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildLocationSelector()),
          SliverToBoxAdapter(child: _buildPromoCarousel(controller)),
          SliverToBoxAdapter(child: _buildCategoryMenu()),
          SliverToBoxAdapter(
            child: Obx(() => _buildProductSection(
                  title: 'Ramah Pemula',
                  products: controller.state.value?.beginnerProducts ?? [],
                )),
          ),
          SliverToBoxAdapter(child: _buildPopularBanner()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.625,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount:
                            controller.state.value?.popularProducts.length ?? 0,
                        itemBuilder: (context, index) {
                          final product =
                              controller.state.value?.popularProducts[index];
                          return _buildProductCard(
                            imageUrl: product?.imageUrl ?? '',
                            productName: product?.name ?? '',
                            currentPrice:
                                'Rp${product?.pricePerDay.toStringAsFixed(0) ?? ''}/hari',
                            originalPrice:
                                'Rp${product?.originalPrice.toStringAsFixed(0) ?? ''}/hari',
                            discount: '${product?.discountPercentage ?? ''}%',
                            context: context,
                            productId: product?.id ?? 0,
                          );
                        },
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigate to search page with seamless transition
                Get.toNamed(Routes.SEARCH);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Cari Produk',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(Icons.notifications_none),
          const SizedBox(width: 10),
          // Builder(
          //   builder: (context) => GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => const MyHome()),
          //       );
          //     },
          //     child: const Icon(Icons.headset_mic_outlined),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildLocationSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Icon(Icons.location_on_outlined),
          Text('Kota Bandung', style: TextStyle(fontWeight: FontWeight.bold)),
          // Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _buildPromoCarousel(HomeController controller) {
    return Obx(() {
      if (controller.state.value?.banners.isEmpty == true) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: FlutterCarousel(
          options: CarouselOptions(
            height: 160,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: (controller.state.value?.banners ?? []).map((banner) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(banner.imageUrl),
                    ),
                  ),
                ),
                Positioned(
                  left: 18,
                  top: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        banner.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        banner.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildCategoryMenu() {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.terrain, 'label': 'Tenda', 'categoryId': 1},
      {'icon': Icons.backpack, 'label': 'Tas', 'categoryId': 5},
      {'icon': Icons.bed, 'label': 'Tidur', 'categoryId': 2},
      {'icon': Icons.restaurant, 'label': 'Masak', 'categoryId': 3},
      {'icon': FontAwesomeIcons.shoePrints, 'label': 'Sepatu', 'categoryId': 4},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Text(
                'Kategori',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: categories.map((category) {
              return InkWell(
                onTap: () => _onCategoryTap(category),
                splashColor: Colors.white,
                highlightColor: Colors.white,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF2F4E3E),
                          width: 1,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white,
                        child: Icon(
                          category['icon'],
                          color: Color(0xFF2F4E3E),
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(category['label'],
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _onCategoryTap(Map<String, dynamic> category) {
    // Navigate to listing page with category filter
    Get.toNamed(
      Routes.LISTING,
      arguments: {
        'category': category['label'],
        'categoryId': category['categoryId'],
      },
    );
  }

  Widget _buildProductSection({
    required String title,
    required List<ProductModel> products,
  }) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                // Text('Lihat Semua', style: TextStyle(color: Color(0xFF2F4E3E))),
              ],
            ),
          ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                width: 150,
                margin: const EdgeInsets.only(right: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      print('Product ID: ${product.id}');
                      Get.toNamed(
                        Routes.PRODUCT_DETAIL,
                        arguments: {'productId': product.id},
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                product.imageUrl,
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
                                'Rp${product.pricePerDay.toStringAsFixed(0)}/hari',
                                style: const TextStyle(
                                  color: Color(0xFF2F4E3E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rp${product.originalPrice.toStringAsFixed(0)}/hari',
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
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularBanner() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/bg-promo2.jpg',
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
          ),
          const Positioned(
            left: 16,
            top: 16,
            child: Text(
              'Paling Populer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            left: 16,
            top: 40,
            child: Text(
              'Produk yang paling banyak dipilih',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String imageUrl,
    required String productName,
    required String currentPrice,
    required String originalPrice,
    required String discount,
    required BuildContext context,
    required int productId,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          print('Product ID from card: $productId');
          Get.toNamed(
            Routes.PRODUCT_DETAIL,
            arguments: {'productId': productId},
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentPrice,
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
                        originalPrice,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        discount,
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
    );
  }
}

class Product {
  final String name;
  final String price;
  final String imageUrl;
  final String originalPrice;

  Product(this.name, this.price, this.imageUrl, this.originalPrice);
}
