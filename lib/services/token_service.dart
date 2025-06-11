import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService extends GetxService {
  static TokenService get to => Get.find();
  final RxString _token = ''.obs;
  final RxString _tokenType = 'Bearer'.obs;
  static const String _tokenKey = 'auth_token';
  final SharedPreferences _prefs;

  TokenService(this._prefs);

  String get token => _token.value;
  String get tokenType => _tokenType.value;
  bool get isLoggedIn => _token.value.isNotEmpty;

  // Inisialisasi service
  Future<TokenService> init() async {
    _token.value = await _prefs.getString(_tokenKey) ?? '';
    _tokenType.value = await _prefs.getString('token_type') ?? 'Bearer';
    return this;
  }

  // Simpan token
  Future<void> saveToken(String token, String tokenType) async {
    _token.value = token;
    _tokenType.value = tokenType;

    await _prefs.setString(_tokenKey, token);
    await _prefs.setString('token_type', tokenType);
  }

  // Hapus token (untuk logout)
  Future<void> clearToken() async {
    _token.value = '';
    _tokenType.value = 'Bearer';

    await _prefs.remove(_tokenKey);
    await _prefs.remove('token_type');
  }

  // Mendapatkan header Authorization
  Map<String, String> getAuthHeader() {
    if (!isLoggedIn) return {};
    return {
      'Authorization': '$tokenType ${token}',
    };
  }

  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }
}
