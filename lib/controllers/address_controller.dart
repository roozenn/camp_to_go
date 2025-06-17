import 'package:get/get.dart';
import '../models/address_model.dart';
import '../services/address_service.dart';

class AddressController extends GetxController {
  final AddressService _addressService = Get.find<AddressService>();
  var addresses = <Address>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  final RxInt selectedAddressId = (-1).obs; // -1 berarti belum ada yang dipilih

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  void selectAddress(int addressId) {
    selectedAddressId.value = addressId;
  }

  bool isAddressSelected(int addressId) {
    return selectedAddressId.value == addressId;
  }

  Future<void> fetchAddresses() async {
    try {
      isLoading.value = true;
      error.value = '';
      final result = await _addressService.getAddresses();
      addresses.assignAll(result);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addAddress({
    required String recipientName,
    required String fullAddress,
    required String phoneNumber,
    required bool isDefault,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final address = Address(
        id: 0, // ID akan diisi oleh server
        recipientName: recipientName,
        fullAddress: fullAddress,
        phoneNumber: phoneNumber,
        isDefault: isDefault,
      );

      final success = await _addressService.addAddress(address);
      if (success) {
        await fetchAddresses(); // Refresh daftar alamat
      } else {
        throw Exception('Gagal menambahkan alamat');
      }
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAddress({
    required int id,
    required String recipientName,
    required String fullAddress,
    required String phoneNumber,
    required bool isDefault,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final address = Address(
        id: id,
        recipientName: recipientName,
        fullAddress: fullAddress,
        phoneNumber: phoneNumber,
        isDefault: isDefault,
      );

      final success = await _addressService.updateAddress(id, address);
      if (success) {
        await fetchAddresses(); // Refresh daftar alamat
      } else {
        throw Exception('Gagal memperbarui alamat');
      }
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAddress(int id) async {
    try {
      isLoading.value = true;
      final success = await _addressService.deleteAddress(id);
      if (success) {
        await fetchAddresses();
      } else {
        error.value = 'Gagal menghapus alamat';
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
