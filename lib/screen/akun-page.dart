import 'package:flutter/material.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({Key? key}) : super(key: key);

  @override
  State<AkunPage> createState() => _HomePageState();
}

class _HomePageState extends State<AkunPage> {
  int _selectedIndex = 3; // Start with Akun selected

  final List<Widget> _pages = [
    const Center(child: Text('Home Page')),
    const Center(child: Text('Cart Page')),
    const Center(child: Text('Transaksi Page')),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF3A5A40),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,

        title: const Text(
          'Akun',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildMenuItem(Icons.person_outline, 'Profil'),
          _buildMenuItem(Icons.location_on_outlined, 'Alamat'),
          _buildMenuItem(Icons.credit_card_outlined, 'Metode Pembayaran'),
          _buildMenuItem(Icons.headset_mic_outlined, 'Hubungi Kami'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87, size: 24),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
