import 'package:flutter/material.dart';

class TransaksiPage extends StatelessWidget {
  final List<Map<String, String>> transaksiList = [
    {
      'kode': 'TRX2301ABC',
      'tanggal': '4 Mei, 2025',
      'status': 'Dalam Penyewaan',
      'jumlah': '3 Barang disewa',
      'total': 'Rp450.000',
    },
    {
      'kode': 'TRX2104XYZ',
      'tanggal': '28 April, 2025',
      'status': 'Selesai',
      'jumlah': '1 Barang disewa',
      'total': 'Rp150.000',
    },
    {
      'kode': 'TRX2003LMN',
      'tanggal': '15 April, 2025',
      'status': 'Dibatalkan',
      'jumlah': '2 Barang disewa',
      'total': 'Rp300.000',
    },
    {
      'kode': 'TRX1902PQR',
      'tanggal': '2 Maret, 2025',
      'status': 'Selesai',
      'jumlah': '4 Barang disewa',
      'total': 'Rp600.000',
    },
    {
      'kode': 'TRX1801DEF',
      'tanggal': '25 Februari, 2025',
      'status': 'Dalam Proses',
      'jumlah': '1 Barang disewa',
      'total': 'Rp120.000',
    },
  ];

  TransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Transaksi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: transaksiList.length,
        itemBuilder: (context, index) {
          final transaksi = transaksiList[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaksi['kode']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    transaksi['tanggal']!,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: DashedLine(),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status Order'),
                      Text(transaksi['status']!),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Jumlah Barang'),
                      Text(transaksi['jumlah']!),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Biaya'),
                      Text(
                        transaksi['total']!,
                        style: TextStyle(
                          color: Color(0xFF2F4E3E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 2,
      //   selectedItemColor: Color(0xFF2F4E3E),
      //   unselectedItemColor: Colors.grey,
      //   showUnselectedLabels: true,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart_outlined),
      //       label: 'Cart',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.receipt_long_outlined),
      //       label: 'Transaksi',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_outline),
      //       label: 'Akun',
      //     ),
      //   ],
      // ),
    );
  }
}

class DashedLine extends StatelessWidget {
  final double height;
  final Color color;

  const DashedLine({this.height = 1, this.color = const Color(0xFFBDBDBD)});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashSpace = 3.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}
