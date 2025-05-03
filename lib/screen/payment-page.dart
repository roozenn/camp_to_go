import 'package:flutter/material.dart';

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      PaymentMethod(
        icon: Icons.credit_card,
        title: 'Kartu Credit atau Debit',
        isSelected: true,
      ),
      PaymentMethod(
        networkImageUrl:
            'https://raw.githubusercontent.com/roozenn/camp_to_go/main/lib/image/gopayicon.png',
        title: 'Gopay',
      ),
      PaymentMethod(
        networkImageUrl:
            'https://raw.githubusercontent.com/roozenn/camp_to_go/main/lib/image/ovoicon.jpeg',
        title: 'Ovo',
      ),
      PaymentMethod(
        networkImageUrl:
            'https://raw.githubusercontent.com/roozenn/camp_to_go/main/lib/image/spayicon.png',
        title: 'ShopeePay',
      ),
      PaymentMethod(icon: Icons.account_balance, title: 'Transfer Bank'),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Pembayaran',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          final method = paymentMethods[index];
          return Container(
            color:
                method.isSelected
                    ? const Color(0xFFEFF3FF)
                    : Colors.transparent,
            child: ListTile(
              leading:
                  method.networkImageUrl != null
                      ? Image.network(
                        method.networkImageUrl!,
                        width: 24,
                        height: 24,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported),
                      )
                      : Icon(method.icon, color: Colors.black),
              title: Text(
                method.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                // Logika seleksi bisa ditambahkan di sini
              },
            ),
          );
        },
      ),
    );
  }
}

class PaymentMethod {
  final IconData? icon;
  final String? networkImageUrl;
  final String title;
  final bool isSelected;

  PaymentMethod({
    this.icon,
    this.networkImageUrl,
    required this.title,
    this.isSelected = false,
  });
}
