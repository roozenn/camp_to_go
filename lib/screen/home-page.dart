import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
      body: SafeArea(
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
                    'Quechua 2 Second Easy Tent',
                    'Rp76.000/hari',
                    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1.webp',
                  ),
                  Product(
                    'NH Escape 500 23L',
                    'Rp76.000/hari',
                    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1.webp',
                  ),
                  Product(
                    'NH Escape 500 23L',
                    'Rp76.000/hari',
                    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1.webp',
                  ),
                  Product(
                    'NH Escape 500 23L',
                    'Rp76.000/hari',
                    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1.webp',
                  ),
                  Product(
                    'NH Escape 500 23L',
                    'Rp76.000/hari',
                    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1.webp',
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
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1.webp',
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Forclaz Men\'s MT900 Symbium2',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Rp76.000/hari',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Rp100.000/hari',
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '24%',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                fillColor: Colors.white,
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
          Icon(Icons.headset_mic_outlined),
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
      padding: const EdgeInsets.all(16),
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
                    left: 16,
                    top: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          promo['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          promo['discount'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
              Text('Lihat Semua', style: TextStyle(color: Colors.green[700])),
            ],
          ),
        ),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final cat = categories[index];
              return Column(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(cat['icon'] as IconData, color: Colors.black),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cat['label'] as String,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            },
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
                Text('Lihat Semua', style: TextStyle(color: Colors.green[700])),
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
                width: 160,
                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        product.imageUrl,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.price,
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Rp100.000/hari',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const Text(
                              '24%',
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
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
}

class Product {
  final String name;
  final String price;
  final String imageUrl;

  Product(this.name, this.price, this.imageUrl);
}
