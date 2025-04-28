import 'package:flutter/material.dart';

class ProductDetailPageGPT extends StatelessWidget {
  const ProductDetailPageGPT({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildTopBar(),
            const SizedBox(height: 16),
            _buildImageCarousel(),
            const SizedBox(height: 16),
            _buildTitleAndFavorite(),
            _buildPriceSection(),
            const SizedBox(height: 16),
            _buildDatePicker(),
            const SizedBox(height: 24),
            _buildDescription(),
            const SizedBox(height: 24),
            _buildReviewSection(),
            const SizedBox(height: 24),
            _buildRecommendations(),
            const SizedBox(height: 24),
            _buildSewaButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: const [
        Icon(Icons.arrow_back_ios, size: 20),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            'Forclaz Men\'s MT...',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Icon(Icons.favorite_border),
      ],
    );
  }

  Widget _buildImageCarousel() {
    return Column(
      children: [
        Image.network(
          'https://images.unsplash.com/photo-1530541930197-ff16ac917b0e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == 2 ? Colors.blueGrey : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleAndFavorite() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            'Forclaz Men\'s MT900 Symbium2',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Icon(Icons.favorite_border),
      ],
    );
  }

  Widget _buildRatingStars(double rating) {
    final fullStars = rating.floor();
    final halfStar = (rating - fullStars) >= 0.5;
    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, size: 20, color: Colors.amber);
        } else if (index == fullStars && halfStar) {
          return const Icon(Icons.star_half, size: 20, color: Colors.amber);
        } else {
          return const Icon(Icons.star_border, size: 20, color: Colors.amber);
        }
      }),
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        _buildRatingStars(4.5),
        const SizedBox(height: 8),
        const Text(
          'Rp76.000/hari',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 4),
        const Text('Deposit : Rp128.000'),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih Tanggal',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('14 April - 16 April 2025'),
              Icon(Icons.calendar_today, size: 18),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Deskripsi', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Text(
          'Tenda ini menggabungkan fabric anti air berkualitas tinggi dengan rangka inovatif yang ringan namun kokoh, menghasilkan kenyamanan optimal.',
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Ulasan', style: TextStyle(fontWeight: FontWeight.w600)),
            Text('Lihat Semua', style: TextStyle(color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildRatingStars(4.5),
            const SizedBox(width: 8),
            const Text('4.5 (5 Ulasan)'),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://i.imgur.com/BoN9kdC.png'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aditya Nugraha',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                _buildRatingStars(4),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Tenda ini sangat nyaman digunakan, bersih, dan benar-benar sempurna dalam segala hal. Hanya saja, tas penyimpanannya terlalu kecil sehingga membuat tenda sedikit terlipat.',
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://images.unsplash.com/photo-1530541930197-ff16ac917b0e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text('December 10, 2024', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rekomendasi Untuk Kamu',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              3,
              (index) => Container(
                width: 140,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1530541930197-ff16ac917b0e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Forclaz Men\'s MT900 Symbium...',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Rp76.000/hari',
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                    const Text(
                      'Rp100.000/hari',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSewaButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade800,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {},
      child: const Text(
        'Sewa',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
