import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:camp_to_go/screen/home-page.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final String selectedDateRange = '14 April - 16 April 2025';
  int _currentPage = 0;

  final List<String> productImages = [
    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1.webp',
    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1-detail1.webp',
    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1-detail2.webp',
    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1-detail3.webp',
  ];

  final List<String> reviewImages = [
    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1-commenter1.webp',
    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1-commenter2.webp',
    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1-commenter3.webp',
  ];

  final List<Product> recommendedProducts = [
    Product(
      'Simond Rock 2.0 Hiking Boots',
      'Rp90.000/hari',
      'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/sepatu2.webp',
      'Rp130.000/hari',
    ),
    Product(
      'Forclaz MT500 Hiking Boots',
      'Rp85.000/hari',
      'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/sepatu1.webp',
      'Rp120.000/hari',
    ),
    Product(
      'NH Escape 500 23L',
      'Rp45.000/hari',
      'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tas1.webp',
      'Rp70.000/hari',
    ),
    Product(
      'Quechua Arpenaz 4.1',
      'Rp120.000/hari',
      'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1.webp',
      'Rp150.000/hari',
    ),

    Product(
      'Quechua Air Fresh 500',
      'Rp65.000/hari',
      'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda2.webp',
      'Rp90.000/hari',
    ),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.product.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
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
                  // TODO: Implementasi logika keranjang
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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 8),
            // Product Image Carousel
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CarouselSlider(
                items:
                    productImages.map((imageUrl) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(imageUrl),
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
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Indikator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                productImages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentPage == index
                            ? Color(0xFF2F4E3E)
                            : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Title
            const Text(
              "Forclaz Men's MT900 Symbium2",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Rating
            Row(
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star_half, color: Colors.amber, size: 20),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              "Rp76.000/hari",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F4E3E),
              ),
            ),
            const SizedBox(height: 2),
            const Text("Deposit : Rp128.000"),
            const SizedBox(height: 20),
            // Date Picker (Placeholder)
            const Text(
              "Pilih Tanggal",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(selectedDateRange)),
                  Icon(Icons.calendar_today, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Deskripsi
            const Text(
              "Deskripsi",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Tenda ini menggabungkan fabric anti air berkualitas tinggi dengan rangka inovatif yang ringan namun kokoh, menghasilkan kenyamanan optimal.",
              style: TextStyle(color: Colors.black87),
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
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 18),
                Icon(Icons.star, color: Colors.amber, size: 18),
                Icon(Icons.star, color: Colors.amber, size: 18),
                Icon(Icons.star, color: Colors.amber, size: 18),
                Icon(Icons.star_half, color: Colors.amber, size: 18),
                SizedBox(width: 8),
                Text("4.5 (5 Ulasan)"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/commenter.png',
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Aditya Nugraha",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Tenda ini sangat nyaman digunakan, bersih, dan benar-benar sempurna dalam segala hal. Hanya saja, tas penyimpanannya terlalu kecil sehingga membuat tenda sedikit terlipat. Saya tidak yakin apakah tasnya bisa kuat terlipat lama.",
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    reviewImages
                        .map(
                          (imageUrl) => Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            const SizedBox(height: 4),
            const Text("December 10, 2024"),
            const SizedBox(height: 30),
            const Text(
              "Rekomendasi Untuk Kamu",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children:
                    recommendedProducts
                        .map((product) => recommendationCard(product))
                        .toList(),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget recommendationCard(Product product) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 8),
      child: Card(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
