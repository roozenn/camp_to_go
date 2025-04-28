import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            // Navigation action
          },
        ),
        title: Text(
          'Pembayaran',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Payment Methods List
          PaymentMethodItem(
            icon: Icons.credit_card,
            title: 'Kartu Credit atau Debit',
            isSelected: true,
            onTap: () {},
          ),
          PaymentMethodItem(
            icon: Icons.payment,
            title: 'Paypal',
            isSelected: false,
            onTap: () {},
            iconWidget: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset('assets/paypal.png', width: 24, height: 24),
              // If you don't have the PayPal image, you can use this:
              // child: Icon(Icons.payment, color: Colors.blue),
            ),
          ),
          PaymentMethodItem(
            icon: Icons.account_balance,
            title: 'Transfer Bank',
            isSelected: false,
            onTap: () {},
          ),
          Spacer(),
          // Bottom placeholder for additional content
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.grey[300],
            margin: EdgeInsets.only(bottom: 20),
          ),
        ],
      ),
    );
  }
}

class PaymentMethodItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? iconWidget;

  const PaymentMethodItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.iconWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: isSelected ? Color(0xFFF0F5FF) : Colors.white,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: iconWidget ?? Icon(icon, color: Colors.black54),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue),
                ),
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
