import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import '../models/address_model.dart';
import '../controllers/address_controller.dart';

class AddressListScreen extends StatelessWidget {
  final bool isFromAccount;

  const AddressListScreen({Key? key, this.isFromAccount = false})
      : super(key: key);

  void _showAddAddressDialog(AddressController controller) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final RxBool isDefault = false.obs;

    Get.dialog(
      AlertDialog(
        title: const Text('Tambah Alamat Baru'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Penerima',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Alamat Lengkap',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              Obx(() => SwitchListTile(
                    title: const Text('Set sebagai alamat default'),
                    value: isDefault.value,
                    onChanged: (value) => isDefault.value = value,
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  addressController.text.isEmpty ||
                  phoneController.text.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Semua field harus diisi',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              try {
                await controller.addAddress(
                  recipientName: nameController.text,
                  fullAddress: addressController.text,
                  phoneNumber: phoneController.text,
                  isDefault: isDefault.value,
                );
                if (isDefault.value) {
                  await Future.delayed(const Duration(milliseconds: 100));
                  final newAddress = controller.addresses.last;
                  controller.selectAddress(newAddress.id);
                }
                Get.back();
                Get.snackbar(
                  'Sukses',
                  'Alamat berhasil ditambahkan',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF2F4E3E),
                  colorText: Colors.white,
                );
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Gagal menambahkan alamat',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F4E3E),
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showEditAddressDialog(AddressController controller, Address address) {
    final TextEditingController nameController =
        TextEditingController(text: address.recipientName);
    final TextEditingController addressController =
        TextEditingController(text: address.fullAddress);
    final TextEditingController phoneController =
        TextEditingController(text: address.phoneNumber);
    final RxBool isDefault = address.isDefault.obs;

    Get.dialog(
      AlertDialog(
        title: const Text('Ubah Alamat'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Penerima',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Alamat Lengkap',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              Obx(() => SwitchListTile(
                    title: const Text('Set sebagai alamat default'),
                    value: isDefault.value,
                    onChanged: (value) => isDefault.value = value,
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  addressController.text.isEmpty ||
                  phoneController.text.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Semua field harus diisi',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              try {
                await controller.updateAddress(
                  id: address.id,
                  recipientName: nameController.text,
                  fullAddress: addressController.text,
                  phoneNumber: phoneController.text,
                  isDefault: isDefault.value,
                );
                Get.back();
                Get.snackbar(
                  'Sukses',
                  'Alamat berhasil diperbarui',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF2F4E3E),
                  colorText: Colors.white,
                );
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Gagal memperbarui alamat',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F4E3E),
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AddressController controller = Get.find<AddressController>();
    // Ambil argument dari Get.arguments jika ada
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?;
    final bool fromAccount = arguments?['isFromAccount'] ?? isFromAccount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Alamat Pengiriman',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () => _showAddAddressDialog(controller),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.error.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.error.value,
                          style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.fetchAddresses,
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                );
              }
              if (controller.addresses.isEmpty) {
                return const Center(
                  child: Text('Belum ada alamat tersimpan'),
                );
              }
              final sortedAddresses = controller.addresses.toList()
                ..sort((a, b) =>
                    (b.isDefault ? 1 : 0).compareTo(a.isDefault ? 1 : 0));

              // Pilih alamat default jika belum ada alamat yang dipilih dan bukan dari akun-page
              if (!fromAccount && controller.selectedAddressId.value == -1) {
                final defaultAddress = sortedAddresses.firstWhere(
                  (address) => address.isDefault,
                  orElse: () => sortedAddresses.first,
                );
                controller.selectAddress(defaultAddress.id);
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ...sortedAddresses.map((address) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _buildAddressCard(
                              address, controller, fromAccount),
                        );
                      }).toList(),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: fromAccount
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (controller.selectedAddressId.value == -1) {
                    Get.snackbar(
                      'Peringatan',
                      'Silakan pilih alamat terlebih dahulu',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red[100],
                      colorText: Colors.red[900],
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                      icon: const Icon(Icons.warning_amber_rounded,
                          color: Colors.red),
                    );
                    return;
                  }
                  Get.toNamed(Routes.PAYMENT);
                },
                backgroundColor: const Color(0xFF2F4E3E),
                label: const Text(
                  'Selanjutnya',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
      floatingActionButtonLocation:
          fromAccount ? null : FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildAddressCard(
      Address address, AddressController controller, bool fromAccount) {
    if (fromAccount) {
      // Mode akun - tidak menggunakan Obx karena tidak ada reactive state
      return GestureDetector(
        onTap: null, // Tidak bisa diklik di mode akun
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          address.recipientName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (address.isDefault)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4E3E),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Default',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    address.fullAddress,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    address.phoneNumber,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildActionButton('Ubah',
                          () => _showEditAddressDialog(controller, address)),
                      const SizedBox(width: 12),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => controller.deleteAddress(address.id),
                          borderRadius: BorderRadius.circular(4),
                          hoverColor: Colors.red.withOpacity(0.1),
                          splashColor: Colors.red.withOpacity(0.2),
                          highlightColor: Colors.red.withOpacity(0.3),
                          child: Ink(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.grey.shade600,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      // Mode checkout - menggunakan Obx untuk reactive state
      return Obx(() => GestureDetector(
            onTap: () => controller.selectAddress(address.id),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: controller.isAddressSelected(address.id)
                      ? const Color(0xFF2F4E3E)
                      : Colors.grey.shade300,
                  width: controller.isAddressSelected(address.id) ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              address.recipientName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (address.isDefault)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2F4E3E),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Default',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        address.fullAddress,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        address.phoneNumber,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildActionButton(
                              'Ubah',
                              () =>
                                  _showEditAddressDialog(controller, address)),
                          const SizedBox(width: 12),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => controller.deleteAddress(address.id),
                              borderRadius: BorderRadius.circular(4),
                              hoverColor: Colors.red.withOpacity(0.1),
                              splashColor: Colors.red.withOpacity(0.2),
                              highlightColor: Colors.red.withOpacity(0.3),
                              child: Ink(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey.shade600,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (controller.isAddressSelected(address.id))
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2F4E3E),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ));
    }
  }

  Widget _buildActionButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF2F4E3E),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
