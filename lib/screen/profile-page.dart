import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black87),
            onPressed: () => controller.refreshProfile(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.refreshProfile(),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        final profile = controller.profile.value;
        if (profile == null) {
          return const Center(
            child: Text('Data profil tidak ditemukan'),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: profile.profilePicture.isNotEmpty
                        ? NetworkImage(profile.profilePicture)
                        : const NetworkImage(
                            'https://raw.githubusercontent.com/roozenn/camp_to_go/refs/heads/main/lib/image/profil.png',
                          ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profile.fullName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text('@${profile.username}',
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            ProfileTile(
              icon: Icons.wc,
              label: 'Jenis Kelamin',
              value: profile.gender,
            ),
            ProfileTile(
              icon: Icons.calendar_today,
              label: 'Tanggal Lahir',
              value: profile.dateOfBirth,
            ),
            ProfileTile(
              icon: Icons.email_outlined,
              label: 'Email',
              value: profile.email,
            ),
            ProfileTile(
              icon: Icons.phone_iphone,
              label: 'Telepon',
              value: profile.phoneNumber,
            ),
            const ProfileTile(
              icon: Icons.lock_outline,
              label: 'Ubah Kata Sandi',
              value: '••••••••••',
            ),
          ],
        );
      }),
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

            // const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
