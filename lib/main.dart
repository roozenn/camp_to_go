import 'package:camp_to_go/screen/cart-page-gpt.dart';
import 'package:camp_to_go/unused/product-detail-page-gpt.dart';
import 'package:camp_to_go/theme-colors.dart';
import 'package:camp_to_go/screen/address-list-screen.dart';
import 'package:camp_to_go/screen/akun-page.dart';
import 'package:camp_to_go/unused/checkout-page.dart';
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
      home: HomePage(),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  margin: EdgeInsets.only(top: 20, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Roshan Syalwan Nurilham',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text('2203142', style: TextStyle(fontSize: 20)),
                      Text('Kelompok 10', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 50,
                //       vertical: 20,
                //     ), // Padding horizontal dan vertical
                //   ),
                //   child: const Text(
                //     'CheckoutPage',
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return CheckoutPage();
                //         },
                //       ),
                //     );
                //   },
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('CartPage', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CartPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'DetailOrderScreen',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          // return DetailOrderScreen();

                          return DetailOrderPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'ListingPage',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          // return ListingPage();
                          return ProductListPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'PaymentPage',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return PembayaranPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                //   ),
                //   child: const Text(
                //     'ProductDetailPage',
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return ProductDetailPage(product: null,);
                //         },
                //       ),
                //     );
                //   },
                // ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'TransactionPage',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return TransaksiPage();
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
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
