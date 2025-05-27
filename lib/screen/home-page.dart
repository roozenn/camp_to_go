/*
 * STRUKTUR KODE PROGRAM - Home Page
 * 
 * 1. Import Statements
 *    - flutter/material.dart
 *    - carousel_slider/carousel_slider.dart
 *    - camp_to_go/screen/my-home.dart
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
import 'package:carousel_slider/carousel_slider.dart';
import 'package:camp_to_go/screen/cart-page-gpt.dart';
import 'package:camp_to_go/screen/transaction-page.dart';
import 'package:camp_to_go/screen/akun-page.dart';
import 'package:camp_to_go/screen/product-detail-page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const CartPage(),
    TransaksiPage(),
    const AkunPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF2F4E3E),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Keranjang',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'Transaksi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildLocationSelector()),
          SliverToBoxAdapter(child: _buildPromoCarousel()),
          SliverToBoxAdapter(child: _buildCategoryMenu()),
          SliverToBoxAdapter(
            child: _buildProductSection(
              title: 'Ramah Pemula',
              products: [
                Product(
                  'Quechua Arpenaz 4.1',
                  'Rp120.000/hari',
                  'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1.webp',
                  'Rp150.000/hari',
                ),
                Product(
                  'Forclaz MT500 Hiking Boots',
                  'Rp85.000/hari',
                  'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/sepatu1.webp',
                  'Rp120.000/hari',
                ),
                Product(
                  'Quechua Air Fresh 500',
                  'Rp65.000/hari',
                  'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda2.webp',
                  'Rp90.000/hari',
                ),
                Product(
                  'Simond Rock 2.0 Hiking Boots',
                  'Rp90.000/hari',
                  'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/sepatu2.webp',
                  'Rp130.000/hari',
                ),
                Product(
                  'NH Escape 500 23L',
                  'Rp45.000/hari',
                  'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tas1.webp',
                  'Rp70.000/hari',
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: _buildPopularBanner()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.625,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final products = [
                        {
                          'imageUrl':
                              'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda3.webp',
                          'productName': 'Quechua 2 Second Easy Tent',
                          'currentPrice': 'Rp150.000/hari',
                          'originalPrice': 'Rp200.000/hari',
                          'discount': '25%',
                        },
                        {
                          'imageUrl':
                              'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/sepatu3.webp',
                          'productName': 'Forclaz Trek 900',
                          'currentPrice': 'Rp95.000/hari',
                          'originalPrice': 'Rp120.000/hari',
                          'discount': '21%',
                        },
                        {
                          'imageUrl':
                              'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/kompor1.webp',
                          'productName': 'Quechua Camping Stove',
                          'currentPrice': 'Rp55.000/hari',
                          'originalPrice': 'Rp75.000/hari',
                          'discount': '27%',
                        },
                        {
                          'imageUrl':
                              'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/kasur1.webp',
                          'productName': 'NH Comfort 500 Sleeping Bag',
                          'currentPrice': 'Rp70.000/hari',
                          'originalPrice': 'Rp90.000/hari',
                          'discount': '22%',
                        },
                        {
                          'imageUrl':
                              'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/kompor2.webp',
                          'productName': 'Eiger Stove Lipat',
                          'currentPrice': 'Rp20.000/hari',
                          'originalPrice': 'Rp40.000/hari',
                          'discount': '22%',
                        },
                        {
                          'imageUrl':
                              'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/kasur2.webp',
                          'productName': 'The East 700 Sleeping Bag',
                          'currentPrice': 'Rp100.000/hari',
                          'originalPrice': 'Rp120.000/hari',
                          'discount': '22%',
                        },
                      ];

                      return _buildProductCard(
                        imageUrl: products[index]['imageUrl']!,
                        productName: products[index]['productName']!,
                        currentPrice: products[index]['currentPrice']!,
                        originalPrice: products[index]['originalPrice']!,
                        discount: products[index]['discount']!,
                        context: context,
                      );
                    },
                  ),
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
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Produk',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(Icons.notifications_none),
          const SizedBox(width: 10),
          Builder(
            builder:
                (context) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHome()),
                    );
                  },
                  child: const Icon(Icons.headset_mic_outlined),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Text('Kota Bandung', style: TextStyle(fontWeight: FontWeight.bold)),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _buildPromoCarousel() {
    final List<Map<String, dynamic>> promos = [
      {
        'title': 'Paket Camping Hemat',
        'discount': 'Diskon 30%',
        'image':
            'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/promo-pakethemat.webp',
      },
      {
        'title': 'Sewa 3 Hari Gratis 1',
        'discount': 'Promo Spesial',
        'image':
            'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/promo-3plus1.webp',
      },
      {
        'title': 'Paket Keluarga',
        'discount': 'Diskon 25%',
        'image':
            'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/promo-paketkeluarga.webp',
      },
      {
        'title': 'Weekend Special',
        'discount': 'Diskon 40%',
        'image':
            'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/promo-weekend.webp',
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 160,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items:
            promos.map((promo) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(promo['image']),
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
                          promo['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          promo['discount'],
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
  }

  Widget _buildCategoryMenu() {
    final categories = [
      {'icon': Icons.terrain, 'label': 'Tenda'},
      {'icon': Icons.backpack, 'label': 'Tas'},
      {'icon': Icons.bed, 'label': 'Tidur'},
      {'icon': Icons.restaurant, 'label': 'Masak'},
      {'icon': Icons.more_horiz, 'label': 'Semua'},
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
              const Spacer(),
              Text('Lihat Semua', style: TextStyle(color: Color(0xFF2F4E3E))),
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                categories.map((cat) {
                  return Column(
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
                            cat['icon'] as IconData,
                            color: Color(0xFF2F4E3E),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat['label'] as String,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProductSection({
    required String title,
    required List<Product> products,
  }) {
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
                Text('Lihat Semua', style: TextStyle(color: Color(0xFF2F4E3E))),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ProductDetailPage(product: product),
                        ),
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
                                product.price,
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
                                    product.originalPrice,
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Text(
                                    '24%',
                                    style: TextStyle(
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
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ProductDetailPage(
                    product: Product(
                      productName,
                      currentPrice,
                      imageUrl,
                      originalPrice,
                    ),
                  ),
            ),
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
