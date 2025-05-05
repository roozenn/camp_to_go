import 'package:flutter/material.dart';

class DetailOrderPage extends StatelessWidget {
  const DetailOrderPage({super.key});

  Widget stepCircle(bool isCompleted) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isCompleted ? Color(0xFF2F4E3E) : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child:
          isCompleted
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : null,
    );
  }

  Widget stepLine() {
    return Container(width: 24, height: 2, color: Colors.grey[300]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Detail Order',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.headset_mic, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OrderStatusStepper(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Produk',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'LQNSU346JK',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                productItem(
                  'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tenda1.webp',
                  'Dome 4 Person Coleman',
                  '24 Apr - 25 Apr 2025',
                  'Rp76.000',
                  true,
                ),
                const SizedBox(height: 12),
                productItem(
                  'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/tas1.webp',
                  'Carrier 60L Deuter',
                  '24 Apr - 25 Apr 2025',
                  'Rp45.000',
                  false,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Detail Pembayaran",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                paymentDetail(),
                const SizedBox(height: 24),
                const Text(
                  "Detail Penyewaan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                rentalDetail(),
                const SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: const Color(0xFF2F4E3E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
              ),
              onPressed: () {},
              child: const Text(
                'Kembalikan Barang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productItem(
    String imagePath,
    String title,
    String date,
    String price,
    bool isFavorite,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2F4E3E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget paymentDetail() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          paymentRow('Biaya Sewa Barang (2)', 'Rp598.000'),
          const SizedBox(height: 8),
          paymentRow('Deposit (2)', 'Rp128.000'),
          const Divider(thickness: 1),
          paymentRow('Total Biaya', 'Rp766.000', isTotal: true),
        ],
      ),
    );
  }

  Widget paymentRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 14 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Color(0xFF2F4E3E) : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget rentalDetail() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rentalRow('Tanggal Pengiriman', '23 April, 2025'),
          const SizedBox(height: 12),
          rentalRow(
            'Alamat',
            'Kompleks Perumahan Angkatan Darat No.17, Bandung 524111',
          ),
          const SizedBox(height: 12),
          rentalRow('Tanggal Pengembalian', '26 April, 2025'),
        ],
      ),
    );
  }

  Widget rentalRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class OrderStatusStepper extends StatelessWidget {
  const OrderStatusStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              _buildCompletedStep(),
              _buildProgressLine(true),
              _buildCompletedStep(),
              _buildProgressLine(false),
              _buildInactiveStep(),
              _buildProgressLine(false),
              _buildInactiveStep(),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dipesan',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const Text(
                'Penyewaan',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                'Pengembalian',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                'Selesai',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedStep() {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Color(0xFF3A5141),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.check, color: Colors.white, size: 16),
    );
  }

  Widget _buildInactiveStep() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
    );
  }

  Widget _buildProgressLine(bool isCompleted) {
    return Expanded(
      child: Container(
        height: 2,
        color: isCompleted ? const Color(0xFF3A5141) : Colors.grey,
      ),
    );
  }
}
