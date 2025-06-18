import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'api_service.dart';
import 'token_service.dart';

class ReviewService {
  final ApiService _apiService = Get.find<ApiService>();
  final TokenService _tokenService = Get.find<TokenService>();

  Future<Map<String, dynamic>> addReview({
    required int productId,
    required int orderId,
    required int rating,
    required String comment,
    required List<File> images,
  }) async {
    try {
      final token = await _tokenService.getToken();
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Buat multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${_apiService.baseUrl}/reviews'),
      );

      // Tambahkan headers
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Tambahkan fields
      request.fields['product_id'] = productId.toString();
      request.fields['order_id'] = orderId.toString();
      request.fields['rating'] = rating.toString();
      request.fields['comment'] = comment;

      // Tambahkan images
      for (int i = 0; i < images.length; i++) {
        final file = images[i];
        final stream = http.ByteStream(file.openRead());
        final length = await file.length();

        final multipartFile = http.MultipartFile(
          'images',
          stream,
          length,
          filename: 'image_$i.jpg',
        );

        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final jsonData = json.decode(responseData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonData;
      } else {
        throw Exception(jsonData['message'] ?? 'Gagal menambahkan review');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
