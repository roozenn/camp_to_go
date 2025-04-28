import 'package:flutter/material.dart';

class DetailOrderScreen extends StatelessWidget {
  const DetailOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.headset_mic, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 1),
            const OrderStatusStepper(),
            _buildProductSection(),
            const SizedBox(height: 10),
            _buildPaymentDetails(),
            const SizedBox(height: 10),
            _buildDeliveryDetails(),
            const SizedBox(height: 20),
            _buildReturnButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Produk',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'LQNSU346JK',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        ProductItem(
          image: 'https://via.placeholder.com/60',
          name: 'Forclaz Mens MT800 Symbium2',
          date: '24 Apr - 25 Apr 2025',
          price: 'Rp152.000',
          isFavorite: true,
        ),
        const Divider(height: 1),
        ProductItem(
          image: 'https://via.placeholder.com/60',
          name: 'Forclaz Mens MT900 Symbium2',
          date: '24 Apr - 25 Apr 2025',
          price: 'Rp152.000',
          isFavorite: false,
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Detail Pembayaran',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(height: 1),
        _buildPaymentItem('Biaya Sewa Barang (2)', 'Rp598.000'),
        _buildPaymentItem('Deposit (2)', 'Rp128.000'),
        const Divider(height: 1),
        _buildPaymentItem('Total Biaya', 'Rp766.000', isBold: true),
        const Divider(height: 1),
      ],
    );
  }

  Widget _buildPaymentItem(String title, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Detail Penyewaan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(height: 1),
        _buildDeliveryItem('Tanggal Pengiriman', '23 April, 2025'),
        _buildAddressItem(),
        _buildDeliveryItem('Tanggal Pengembalian', '26 April, 2025'),
        const Divider(height: 1),
      ],
    );
  }

  Widget _buildDeliveryItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Alamat',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Kompleks Perumahan Angkatan Darat No.17, Bandung 524111',
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReturnButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3A5141),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
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
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              Text(
                'Selesai',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
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
      decoration: BoxDecoration(
        color: Colors.blue[100],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildProgressLine(bool isCompleted) {
    return Expanded(
      child: Container(
        height: 2,
        color: isCompleted ? const Color(0xFF3A5141) : Colors.blue[100],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final String date;
  final String price;
  final bool isFavorite;

  const ProductItem({
    Key? key,
    required this.image,
    required this.name,
    required this.date,
    required this.price,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: const Icon(Icons.home),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
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
}
