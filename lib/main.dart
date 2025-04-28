import 'package:camp_to_go/unused/cart-page-gpt.dart';
import 'package:camp_to_go/unused/product-detail-page-gpt.dart';
import 'package:camp_to_go/theme-colors.dart';
import 'package:camp_to_go/screen/address-list-screen.dart';
import 'package:camp_to_go/screen/akun-page.dart';
import 'package:camp_to_go/screen/checkout-page.dart';
import 'package:camp_to_go/screen/detail-order-screen.dart';
import 'package:camp_to_go/screen/home-page.dart';
import 'package:camp_to_go/screen/listing-page.dart';
import 'package:camp_to_go/screen/login-screen.dart';
import 'package:camp_to_go/screen/payment-page.dart';
import 'package:camp_to_go/screen/product-detail-page.dart';
import 'package:camp_to_go/screen/profile-page.dart';
import 'package:camp_to_go/screen/regist-page.dart';
import 'package:camp_to_go/screen/search-page.dart';
import 'package:camp_to_go/screen/transaction-page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAMPtoGo',
      theme: buildLightTheme(),
      // darkTheme: buildDarkTheme(),
      home: const MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//perlu  dipisah karena Navigator perlu punya parent Material App
class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('CAMPtoGo')),
      body: Container(
        color: Colors.grey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text(
                    'AddressListScreen',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddressListScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text('AkunPage', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AkunPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text(
                    'CheckoutPage',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CheckoutPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text(
                    'DetailOrderScreen',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailOrderScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text('HomePage', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text(
                    'ListingPage',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ListingPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text(
                    'LoginScreen',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text(
                    'PaymentPage',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return PaymentPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text(
                    'ProductDetailPage',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductDetailPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text(
                    'ProfilePage',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfilePage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text(
                    'RegistrationPage',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RegistrationPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text(
                    'SearchPage',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SearchPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ), // Padding horizontal dan vertical
                  ),
                  child: const Text(
                    'TransactionPage',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return TransactionPage();
                        },
                      ),
                    );
                  },
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 50,
                //       vertical: 20,
                //     ), // Padding horizontal dan vertical
                //   ),
                //   child: const Text('CartPage', style: TextStyle(fontSize: 20)),
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return CartPage();
                //         },
                //       ),
                //     );
                //   },
                // ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 50,
                //       vertical: 20,
                //     ), // Padding horizontal dan vertical
                //   ),
                //   child: const Text(
                //     'ProductDetailPageGPT',
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return ProductDetailPageGPT();
                //         },
                //       ),
                //     );
                // },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
