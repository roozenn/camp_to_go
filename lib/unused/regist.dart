import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Marl Kita Mulai',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nama Panjang',
                  hintText: 'Masukkan nama lengkap',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email Anda',
                  hintText: 'Masukkan alamat email',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Buat password',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password Logi',
                  hintText: 'Konfirmasi password',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Daftar', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Punya etum? '),
                  TextButton(onPressed: () {}, child: const Text('Masuk')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
