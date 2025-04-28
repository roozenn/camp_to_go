import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaksi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        leadingWidth: 30,
        leading: const BackButton(),
      ),
      body: ListView(
        children: [
          TransactionCard(
            orderId: 'LQNSU346JK',
            date: '23 April, 2025',
            status: 'Dalam Penyewaan',
            itemCount: '2 Barang disewa',
            totalCost: 'Rp299.000',
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          TransactionCard(
            orderId: 'SDGI345KJD',
            date: '1 Januari, 2025',
            status: 'Selesai',
            itemCount: '1 Barang disewa',
            totalCost: 'Rp299.000',
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // Transaksi tab is selected
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final String itemCount;
  final String totalCost;

  const TransactionCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.itemCount,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderId,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(date, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Status Order',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: status == 'Selesai' ? Colors.black : Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Jumlah Barang',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                itemCount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Biaya',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                totalCost,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
