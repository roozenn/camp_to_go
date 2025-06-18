import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' hide Response;
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import 'package:camp_to_go/models/product_detail_model.dart';
import 'package:camp_to_go/models/search_suggestions_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'token_service.dart';
import '../models/order_request_model.dart';

class ApiService extends GetxService {
  // Konstanta untuk port API
  static const int API_PORT = 8000;
  final String baseUrl = 'http://localhost:$API_PORT';

  // Headers untuk mengatasi CORS
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  late Dio _dio;
  final TokenService _tokenService = Get.find<TokenService>();

  // Inisialisasi service
  Future<ApiService> init() async {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:8000',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _tokenService.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.type == DioExceptionType.connectionTimeout) {
          print('Koneksi timeout: ${e.message}');
        }
        if (e.response?.statusCode == 401) {
          await _tokenService.clearToken();
          Get.offAllNamed('/login');
        }
        return handler.next(e);
      },
    ));

    return this;
  }

  // Get Banners
  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/home/banners'),
        headers: _headers,
      );
      print('Banner Response: ${response.body}'); // Debug print
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return (data['data'] as List)
              .map((item) => BannerModel.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('Error getting banners: $e');
      return [];
    }
  }

  // Get Categories
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/home/categories'),
        headers: _headers,
      );
      print('Categories Response: ${response.body}'); // Debug print
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return (data['data'] as List)
              .map((item) => CategoryModel.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('Error getting categories: $e');
      return [];
    }
  }

  // Get Search Suggestions
  Future<List<String>> getSearchSuggestions(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/search/suggestions?q=${Uri.encodeComponent(query)}'),
        headers: _headers,
      );
      print('Search Suggestions Response: ${response.body}'); // Debug print
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return List<String>.from(data['data']['suggestions'] ?? []);
        }
      }
      return [];
    } catch (e) {
      print('Error getting search suggestions: $e');
      return [];
    }
  }

  // Get Beginner Products
  Future<List<ProductModel>> getBeginnerProducts({int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/home/recommendations/beginner?limit=$limit'),
        headers: _headers,
      );
      print('Beginner Products Response: ${response.body}'); // Debug print
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return (data['data'] as List)
              .map((item) => ProductModel.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('Error getting beginner products: $e');
      return [];
    }
  }

  // Get Popular Products
  Future<List<ProductModel>> getPopularProducts({int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/home/recommendations/popular?limit=$limit'),
        headers: _headers,
      );
      print('Popular Products Response: ${response.body}'); // Debug print
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return (data['data'] as List)
              .map((item) => ProductModel.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('Error getting popular products: $e');
      return [];
    }
  }

  Future<ProductDetailModel> getProductDetail(int productId) async {
    try {
      print('Fetching product detail for ID: $productId'); // Debug print
      final response = await _dio.get('$baseUrl/products/$productId');

      print('API Response for product detail: ${response.data}'); // Debug print

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          throw Exception('Data produk tidak ditemukan');
        }

        // Fetch reviews separately
        try {
          print('Fetching reviews for product ID: $productId'); // Debug print
          final reviewsResponse = await http.get(
            Uri.parse('$baseUrl/products/$productId/reviews'),
            headers: _headers,
          );
          print('Reviews Response: ${reviewsResponse.body}'); // Debug print

          if (reviewsResponse.statusCode == 200) {
            final reviewsData = json.decode(reviewsResponse.body);
            if (reviewsData['success'] == true) {
              print(
                  'Adding reviews to product data: ${reviewsData['data']}'); // Debug print
              data['reviews'] = reviewsData['data'];
            }
          }
        } catch (e) {
          print('Error fetching reviews: $e');
        }

        print('Final product data with reviews: $data'); // Debug print

        return ProductDetailModel.fromJson(data['data']);
      } else {
        throw Exception('Gagal mengambil data produk');
      }
    } catch (e) {
      print('Error in getProductDetail: $e');
      rethrow;
    }
  }

  Future<List<ProductDetailModel>> getRecommendedProducts() async {
    try {
      print('Fetching recommended products'); // Debug print
      final response = await http.get(
        Uri.parse('$baseUrl/home/recommendations/popular'),
        headers: _headers,
      );

      print('Recommended Products Response: ${response.body}'); // Debug print

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return (data['data'] as List)
              .map((item) =>
                  RecommendedProductModel.fromJson(item).toProductDetailModel())
              .toList();
        }
        throw Exception(
            'Response tidak valid: ${data['message'] ?? 'Unknown error'}');
      } else {
        throw Exception(
            'Failed to load recommended products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getRecommendedProducts: $e'); // Debug print
      return []; // Return empty list instead of throwing error
    }
  }

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      rethrow;
    }
  }

  // Toggle favorite status
  Future<void> toggleFavorite(int productId, bool isFavorited) async {
    try {
      if (isFavorited) {
        await _dio.delete('/favorites/$productId');
      } else {
        await _dio.post('/favorites/$productId');
      }
    } catch (e) {
      print('Error in toggleFavorite: $e');
      rethrow;
    }
  }

  // Create new order
  Future<OrderResponseModel> createOrder(OrderRequestModel orderRequest) async {
    try {
      print(
          'Creating order with data: ${orderRequest.toJson()}'); // Debug print

      final response = await _dio.post('/orders', data: orderRequest.toJson());

      print('Order creation response: ${response.data}'); // Debug print

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          return OrderResponseModel.fromJson(responseData['data']);
        } else {
          throw Exception(responseData['message'] ?? 'Gagal membuat pesanan');
        }
      } else {
        throw Exception('Gagal membuat pesanan: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in createOrder: $e');
      rethrow;
    }
  }
}
