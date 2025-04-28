import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo container
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D472D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.diamond, size: 32, color: Colors.white),
                ),
              ),

              const SizedBox(height: 24.0),

              // Title
              const Text(
                'Mari Kita Mulai',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 4.0),

              // Subtitle
              const Text(
                'Buat akun baru',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 32.0),

              // Name field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama Panjang',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // Email field
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Anda',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // Password field
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // Confirm Password field
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password Lagi',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),

              const SizedBox(height: 32.0),

              // Register button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D472D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // TODO: handle signup action
                  },
                  child: const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Punya akun? '),
                  GestureDetector(
                    onTap: () {
                      // TODO: navigate to login page
                    },
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D472D),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
