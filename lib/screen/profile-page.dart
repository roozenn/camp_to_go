import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/profil.png',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Galih Silalaga',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text('@its_galih', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const ProfileTile(
            icon: Icons.wc,
            label: 'Jenis Kelamin',
            value: 'Pria',
          ),
          const ProfileTile(
            icon: Icons.calendar_today,
            label: 'Tanggal Lahir',
            value: '12-12-2000',
          ),
          const ProfileTile(
            icon: Icons.email_outlined,
            label: 'Email',
            value: 'galih0911@gmail.com',
          ),
          const ProfileTile(
            icon: Icons.phone_iphone,
            label: 'Telepon',
            value: '(307) 555-0133',
          ),
          const ProfileTile(
            icon: Icons.lock_outline,
            label: 'Ubah Kata Sandi',
            value: '••••••••••',
          ),
        ],
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Color(0xFF2F4E3E)),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(value, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(width: 12),

            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
