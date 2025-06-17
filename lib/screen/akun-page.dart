import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/main_bottom_nav.dart';

class AkunPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  AkunPage({super.key});

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF2F4E3E)),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Akun',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          _buildMenuItem(Icons.person_outline, 'Profil'),
          _buildMenuItem(Icons.shopping_bag_outlined, 'Pesanan Saya'),
          _buildMenuItem(Icons.favorite_border, 'Wishlist'),
          _buildMenuItem(Icons.location_on_outlined, 'Alamat'),
          _buildMenuItem(Icons.payment_outlined, 'Metode Pembayaran'),
          _buildMenuItem(Icons.settings_outlined, 'Pengaturan'),
          _buildMenuItem(
            Icons.logout,
            'Logout',
            onTap: () {
              // Tampilkan dialog konfirmasi
              Get.dialog(
                AlertDialog(
                  title: Text('Logout'),
                  content: Text('Apakah Anda yakin ingin keluar?'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back(); // Tutup dialog
                        authController.logout(); // Panggil fungsi logout
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const MainBottomNav(),
    );
  }
}
