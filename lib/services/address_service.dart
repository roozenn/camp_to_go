import 'dart:convert';
import 'package:get/get.dart';
import 'package:camp_to_go/services/token_service.dart';
import '../models/address_model.dart';
import 'package:http/http.dart' as http;

class AddressService extends GetxService {
  static const String baseUrl = 'http://127.0.0.1:8000';
  final TokenService _tokenService = Get.find<TokenService>();

  // Headers untuk mengatasi CORS dan content type
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Mendapatkan header dengan token
  Map<String, String> _getAuthHeaders() {
    return {
      ..._headers,
      ..._tokenService.getAuthHeader(),
    };
  }

  Future<List<Address>> getAddresses() async {
    try {
      if (!_tokenService.isLoggedIn) throw Exception('Belum login');
      final response = await http.get(
        Uri.parse('$baseUrl/addresses'),
        headers: _getAuthHeaders(),
      );

      final Map<String, dynamic> data = json.decode(response.body);
      print('Response getAddresses: $data'); // Debug print

      if (response.statusCode == 200 && data['success'] == true) {
        final List<dynamic> addressesJson = data['data'];
        return addressesJson.map((json) => Address.fromJson(json)).toList();
      }
      throw Exception(data['message'] ?? 'Gagal mengambil data alamat');
    } catch (e) {
      print('Error getAddresses: $e'); // Debug print
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<bool> addAddress(Address address) async {
    try {
      if (!_tokenService.isLoggedIn) throw Exception('Belum login');

      // Hapus id dari request body karena akan diisi oleh server
      final requestBody = {
        'recipient_name': address.recipientName,
        'full_address': address.fullAddress,
        'phone_number': address.phoneNumber,
        'is_default': address.isDefault,
      };

      print('Request body addAddress: $requestBody'); // Debug print

      final response = await http.post(
        Uri.parse('$baseUrl/addresses'),
        headers: _getAuthHeaders(),
        body: json.encode(requestBody),
      );

      final Map<String, dynamic> data = json.decode(response.body);
      print('Response addAddress: $data'); // Debug print

      if (response.statusCode == 200) {
        if (data['success'] == true) {
          return true;
        }
        throw Exception(data['message'] ?? 'Gagal menambahkan alamat');
      }
      throw Exception('Server error: ${response.statusCode}');
    } catch (e) {
      print('Error addAddress: $e'); // Debug print
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<bool> updateAddress(int addressId, Address address) async {
    try {
      if (!_tokenService.isLoggedIn) throw Exception('Belum login');
      final response = await http.put(
        Uri.parse('$baseUrl/addresses/$addressId'),
        headers: _getAuthHeaders(),
        body: json.encode(address.toJson()),
      );

      final Map<String, dynamic> data = json.decode(response.body);
      print('Response updateAddress: $data'); // Debug print

      if (response.statusCode == 200) {
        if (data['success'] == true) {
          return true;
        }
        throw Exception(data['message'] ?? 'Gagal mengupdate alamat');
      }
      throw Exception('Server error: ${response.statusCode}');
    } catch (e) {
      print('Error updateAddress: $e'); // Debug print
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<bool> deleteAddress(int addressId) async {
    try {
      if (!_tokenService.isLoggedIn) throw Exception('Belum login');
      final response = await http.delete(
        Uri.parse('$baseUrl/addresses/$addressId'),
        headers: _getAuthHeaders(),
      );

      final Map<String, dynamic> data = json.decode(response.body);
      print('Response deleteAddress: $data'); // Debug print

      if (response.statusCode == 200) {
        if (data['success'] == true) {
          return true;
        }
        throw Exception(data['message'] ?? 'Gagal menghapus alamat');
      }
      throw Exception('Server error: ${response.statusCode}');
    } catch (e) {
      print('Error deleteAddress: $e'); // Debug print
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
