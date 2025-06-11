import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camp_to_go/services/api_service.dart';
import 'package:camp_to_go/models/banner_model.dart';
import 'package:camp_to_go/models/category_model.dart';
import 'package:camp_to_go/models/product_model.dart';
import 'package:camp_to_go/screen/home-page.dart';
import 'package:camp_to_go/screen/cart-page-gpt.dart';
import 'package:camp_to_go/screen/transaction-page.dart';
import 'package:camp_to_go/screen/akun-page.dart';

class HomeState {
  bool isLoading = false;
  String? error;
  List<BannerModel> banners = [];
  List<CategoryModel> categories = [];
  List<ProductModel> beginnerProducts = [];
  List<ProductModel> popularProducts = [];
}

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final ApiService _apiService = ApiService();
  final Rx<HomeState> state = HomeState().obs;

  // Navigation
  final RxInt selectedIndex = 0.obs;
  late final List<Widget> pages;

  @override
  void onInit() {
    super.onInit();
    pages = [
      const HomeContent(),
      CartPage(),
      TransaksiPage(),
      AkunPage(),
    ];
    loadData();
  }

  Future<void> loadData() async {
    try {
      state.update((val) {
        val?.isLoading = true;
        val?.error = null;
      });

      final banners = await _apiService.getBanners();
      final categories = await _apiService.getCategories();
      final beginnerProducts = await _apiService.getBeginnerProducts();
      final popularProducts = await _apiService.getPopularProducts();

      state.update((val) {
        val?.banners = banners;
        val?.categories = categories;
        val?.beginnerProducts = beginnerProducts;
        val?.popularProducts = popularProducts;
        val?.isLoading = false;
      });
    } catch (e) {
      state.update((val) {
        val?.error = e.toString();
        val?.isLoading = false;
      });
      Get.snackbar(
        'Error',
        'Gagal memuat data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void refreshData() {
    loadData();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
