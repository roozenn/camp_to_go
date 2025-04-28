import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime(2025, 4, 14),
    end: DateTime(2025, 4, 16),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildProductImage(),
              _buildProductTitle(),
              _buildRentalPrice(),
              _buildDatePicker(),
              _buildDescription(),
              _buildReviews(),
              _buildRecommendations(),
              _buildRentButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            onPressed: () {},
          ),
          const Expanded(
            child: Text(
              "Forclaz Men's MT900 Symbium2",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Stack(
        children: [
          Center(
            child: Image.network(
              'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?q=80&w=1770&auto=format&fit=crop',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        index == 1
                            ? Colors.white
                            : Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTitle() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Forclaz Men's MT900 Symbium2",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  Icon(Icons.star, color: Colors.grey, size: 18),
                ],
              ),
            ],
          ),
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildRentalPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Rp76.000/hari",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                "Deposit: ",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                "Rp128.000",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    final formatter = DateFormat('d MMMM');
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pilih Tanggal",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              // Date picker logic would go here
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${formatter.format(selectedDates.start)} - ${formatter.format(selectedDates.end)} ${selectedDates.end.year}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Icon(Icons.calendar_today, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Deskripsi",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            "Tenda ini menggabungkan fabric anti air berkualitas tinggi dengan rangka inovatif yang ringan namun kokoh, menghasilkan kenyamanan optimal.",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Ulasan",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Lihat Semua",
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const Icon(Icons.star, color: Colors.grey, size: 16),
              const SizedBox(width: 8),
              Text(
                "4.5 (5 ulasan)",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildReviewItem(),
        ],
      ),
    );
  }

  Widget _buildReviewItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 16,
              child: Icon(Icons.person, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Aditya Nugraha",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star, color: Colors.grey, size: 16),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "Tenda ini sangat nyaman digunakan, bersih, dan benar-benar sempurna dalam segala hal. Hanya saja, tas penyimpanannya terlalu kecil sehingga membuat tenda sedikit terlipat. Saya tidak yakin apakah tasnya bisa kuat terlipat lama.",
          style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey[200],
              ),
              child: const Icon(Icons.cabin, color: Colors.teal),
            ),
            const SizedBox(width: 8),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey[200],
              ),
              child: const Icon(Icons.water_drop, color: Colors.blue),
            ),
            const SizedBox(width: 8),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey[200],
              ),
              child: const Icon(Icons.backpack, color: Colors.brown),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "December 10, 2024",
          style: TextStyle(color: Colors.grey[400], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Rekomendasi Untuk Kamu",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: List.generate(3, (index) => _buildRecommendationItem()),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationItem() {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.teal.withOpacity(0.2),
            ),
            child: const Center(
              child: Icon(Icons.cabin, size: 40, color: Colors.teal),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              "Forclaz Men's MT900 Symbium2",
              style: TextStyle(fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Text(
                  "Rp76.000/hari",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Text(
                  "Rp100.000/hari",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    "24%",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.red[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRentButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[800],
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          "Sewa",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
