import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: const Text('Profil'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.pink[100],
                  child: ClipOval(
                    child: Image.network(
                      'https://via.placeholder.com/60', // Replace with actual image
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Galih Silalaga',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '@its_galih',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ProfileMenuItem(
            icon: Icons.female,
            title: 'Jenis Kelamin',
            value: 'Pria',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 56),
          ProfileMenuItem(
            icon: Icons.calendar_today,
            title: 'Tanggal Lahir',
            value: '12-12-2000',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 56),
          ProfileMenuItem(
            icon: Icons.email_outlined,
            title: 'Email',
            value: 'galih0911@gmail.com',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 56),
          ProfileMenuItem(
            icon: Icons.phone_android,
            title: 'Telepon',
            value: '(307) 555-0133',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 56),
          ProfileMenuItem(
            icon: Icons.lock_outline,
            title: 'Ubah Kata Sandi',
            value: '••••••••••••••••',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 56),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black54),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
