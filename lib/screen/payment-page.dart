import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import '../services/payment_service.dart';
import '../models/payment_method_model.dart';
import '../controllers/payment_controller.dart';

class PembayaranPage extends StatefulWidget {
  final bool isFromAccount;

  const PembayaranPage({super.key, this.isFromAccount = false});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final PaymentService _paymentService = Get.find<PaymentService>();
  final PaymentController _paymentController = Get.find<PaymentController>();
  int selectedPaymentIndex = -1;

  // Konstanta untuk tipe metode pembayaran
  static const List<String> METHOD_TYPES = [
    "bank_transfer", // Transfer Bank
    "ewallet", // E-Wallet
    "credit_card", // Kartu Kredit
  ];

  // Konstanta untuk provider
  static const Map<String, List<String>> PROVIDERS = {
    "bank_transfer": ["BCA", "Mandiri", "BNI", "BRI"],
    "ewallet": ["OVO", "GoPay", "DANA", "LinkAja", "ShopeePay"],
    "credit_card": ["Visa", "Mastercard", "JCB"],
  };

  @override
  void initState() {
    super.initState();
    _loadPaymentMethods();
  }

  Future<void> _loadPaymentMethods() async {
    await _paymentService.getPaymentMethods();
    // Setelah data dimuat, cari dan pilih metode pembayaran default
    _selectDefaultPaymentMethod();
  }

  void _selectDefaultPaymentMethod() {
    // Ambil argument dari Get.arguments jika ada
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?;
    final bool fromAccount =
        arguments?['isFromAccount'] ?? widget.isFromAccount;

    // Hanya pilih default jika bukan dari akun-page
    if (!fromAccount) {
      final defaultIndex = _paymentService.paymentMethods.indexWhere(
        (method) => method.isDefault,
      );
      if (defaultIndex != -1) {
        setState(() {
          selectedPaymentIndex = defaultIndex;
        });
      }
    }
  }

  void _showAddPaymentMethodDialog() {
    final RxString selectedMethodType = METHOD_TYPES[0].obs;
    final RxString selectedProvider = PROVIDERS[METHOD_TYPES[0]]![0].obs;
    final accountNumberController = TextEditingController();
    final accountNameController = TextEditingController();
    final RxBool isDefault = false.obs;

    Get.dialog(
      AlertDialog(
        title: const Text('Tambah Metode Pembayaran'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dropdown untuk tipe metode pembayaran
              Obx(() => DropdownButtonFormField<String>(
                    value: selectedMethodType.value,
                    decoration: const InputDecoration(
                      labelText: 'Tipe Metode Pembayaran',
                      border: OutlineInputBorder(),
                    ),
                    items: METHOD_TYPES.map((type) {
                      String label;
                      switch (type) {
                        case 'bank_transfer':
                          label = 'Transfer Bank';
                          break;
                        case 'ewallet':
                          label = 'E-Wallet';
                          break;
                        case 'credit_card':
                          label = 'Kartu Kredit';
                          break;
                        default:
                          label = type;
                      }
                      return DropdownMenuItem(
                        value: type,
                        child: Text(label),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        selectedMethodType.value = value;
                        selectedProvider.value = PROVIDERS[value]![0];
                      }
                    },
                  )),
              const SizedBox(height: 16),

              // Dropdown untuk provider
              Obx(() => DropdownButtonFormField<String>(
                    value: selectedProvider.value,
                    decoration: const InputDecoration(
                      labelText: 'Provider',
                      border: OutlineInputBorder(),
                    ),
                    items: PROVIDERS[selectedMethodType.value]!.map((provider) {
                      return DropdownMenuItem(
                        value: provider,
                        child: Text(provider),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        selectedProvider.value = value;
                      }
                    },
                  )),
              const SizedBox(height: 16),

              // TextField untuk nomor rekening
              TextField(
                controller: accountNumberController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Rekening',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // TextField untuk nama pemilik rekening
              TextField(
                controller: accountNameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pemilik Rekening',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Switch untuk isDefault
              Obx(() => SwitchListTile(
                    title: const Text('Set sebagai metode default'),
                    value: isDefault.value,
                    onChanged: (value) {
                      isDefault.value = value;
                    },
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
              if (accountNumberController.text.isEmpty ||
                  accountNameController.text.isEmpty) {
                Get.snackbar(
                  'Peringatan',
                  'Semua field harus diisi',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red[100],
                  colorText: Colors.red[900],
                );
                return;
              }

              try {
                await _paymentService.addPaymentMethod(
                  methodType: selectedMethodType.value,
                  providerName: selectedProvider.value,
                  accountNumber: accountNumberController.text,
                  accountName: accountNameController.text,
                  isDefault: isDefault.value,
                );

                Get.back();
                _loadPaymentMethods(); // Refresh list

                Get.snackbar(
                  'Berhasil',
                  'Metode pembayaran berhasil ditambahkan',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green[100],
                  colorText: Colors.green[900],
                );
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Gagal menambahkan metode pembayaran: $e',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red[100],
                  colorText: Colors.red[900],
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F4E3E),
              foregroundColor: Colors.white,
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil argument dari Get.arguments jika ada
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?;
    final bool fromAccount =
        arguments?['isFromAccount'] ?? widget.isFromAccount;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Pembayaran',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: _showAddPaymentMethodDialog,
          ),
        ],
      ),
      body: Obx(() {
        if (_paymentService.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_paymentService.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _paymentService.error.value,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadPaymentMethods,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        if (_paymentService.paymentMethods.isEmpty) {
          return const Center(
            child: Text('Tidak ada metode pembayaran yang tersedia'),
          );
        }

        return ListView.builder(
          itemCount: _paymentService.paymentMethods.length,
          itemBuilder: (context, index) {
            final method = _paymentService.paymentMethods[index];
            final isSelected =
                fromAccount ? false : selectedPaymentIndex == index;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFEFF3FF) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF2F4E3E)
                      : Colors.grey.shade300,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      method.getImageUrl(),
                      width: 40,
                      height: 40,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ],
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method.providerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'No. Rekening: ${method.accountNumber}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Atas Nama: ${method.accountName}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (method.isDefault)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
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
                    if (!fromAccount && isSelected)
                      Container(
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
                  ],
                ),
                onTap: fromAccount
                    ? null
                    : () {
                        setState(() {
                          selectedPaymentIndex = index;
                        });
                      },
              ),
            );
          },
        );
      }),
      floatingActionButton: fromAccount
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  if (selectedPaymentIndex == -1) {
                    Get.snackbar(
                      'Peringatan',
                      'Silakan pilih metode pembayaran terlebih dahulu',
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

                  // Tampilkan loading indicator
                  Get.dialog(
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    barrierDismissible: false,
                  );

                  // Ambil payment method yang dipilih
                  final selectedPaymentMethod =
                      _paymentService.paymentMethods[selectedPaymentIndex];

                  // Buat order
                  final success = await _paymentController.createOrder(
                    selectedPaymentMethodId: selectedPaymentMethod.id,
                    notes:
                        null, // Bisa ditambahkan field untuk notes jika diperlukan
                  );

                  // Tutup loading dialog
                  Get.back();

                  if (!success) {
                    // Error sudah ditangani di PaymentController
                    return;
                  }
                },
                backgroundColor: const Color(0xFF2F4E3E),
                label: const Text(
                  'Bayar Sekarang',
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

  // Tambahkan method helper untuk mendapatkan label tipe metode pembayaran
  String _getMethodTypeLabel(String methodType) {
    switch (methodType) {
      case 'bank_transfer':
        return 'Transfer Bank';
      case 'ewallet':
        return 'E-Wallet';
      case 'credit_card':
        return 'Kartu Kredit';
      default:
        return methodType;
    }
  }
}
