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

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SearchAndFilterBar(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1.webp',
                        'productName': 'Dome 4 Person Coleman',
                        'currentPrice': 'Rp175.000/hari',
                        'originalPrice': 'Rp250.000/hari',
                        'discount': '30%',
                      },
                      {
                        'imageUrl':
                            'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda2.webp',
                        'productName': 'Family 6 Person Eiger',
                        'currentPrice': 'Rp250.000/hari',
                        'originalPrice': 'Rp350.000/hari',
                        'discount': '29%',
                      },
                      {
                        'imageUrl':
                            'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda3.webp',
                        'productName': 'Ultralight 2 Person Naturehike',
                        'currentPrice': 'Rp120.000/hari',
                        'originalPrice': 'Rp180.000/hari',
                        'discount': '33%',
                      },
                      {
                        'imageUrl':
                            'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda4.webp',
                        'productName': 'Tunnel 8 Person Coleman',
                        'currentPrice': 'Rp350.000/hari',
                        'originalPrice': 'Rp500.000/hari',
                        'discount': '30%',
                      },
                      {
                        'imageUrl':
                            'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda5.webp',
                        'productName': 'Pop Up 3 Person Quechua',
                        'currentPrice': 'Rp150.000/hari',
                        'originalPrice': 'Rp220.000/hari',
                        'discount': '32%',
                      },
                      {
                        'imageUrl':
                            'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda6.webp',
                        'productName': 'Waterproof 2 Person Eiger',
                        'currentPrice': 'Rp130.000/hari',
                        'originalPrice': 'Rp190.000/hari',
                        'discount': '32%',
                      },
                    ];

                    return _buildProductCard(
                      imageUrl: products[index]['imageUrl']!,
                      productName: products[index]['productName']!,
                      currentPrice: products[index]['currentPrice']!,
                      originalPrice: products[index]['originalPrice']!,
                      discount: products[index]['discount']!,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchAndFilterBar extends StatelessWidget {
  const SearchAndFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Tenda',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
        IconButton(
          icon: const Icon(Icons.filter_alt_outlined),
          onPressed: () {},
        ),
      ],
    );
  }
}

Widget _buildProductCard({
  required String imageUrl,
  required String productName,
  required String currentPrice,
  required String originalPrice,
  required String discount,
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
              const SizedBox(height: 12),
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
                  const SizedBox(width: 8),
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
  );
}
