import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';
import '../widgets/main_bottom_nav.dart';
import 'transaction_detail_page.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final TransactionController controller = Get.put(TransactionController());

  @override
  void initState() {
    super.initState();
    controller.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Transaksi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.error.value),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchTransactions(),
                  child: Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        if (controller.transactions.isEmpty) {
          return Center(
            child: Text('Belum ada transaksi'),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final transaksi = controller.transactions[index];
            return Card(
              margin: EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              elevation: 0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.grey.withOpacity(0.1),
                  highlightColor: Colors.grey.withOpacity(0.1),
                  onTap: () {
                    Get.to(() => TransactionDetailPage(
                          orderId: transaksi.id,
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                transaksi.orderNumber,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (transaksi.status == 'ongoing')
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF2F4E3E),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () async {
                                      // Konfirmasi pengembalian barang
                                      bool? confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text('Konfirmasi Pengembalian'),
                                            content: Text(
                                                'Apakah Anda yakin ingin mengembalikan barang ini?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: Text('Batal'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xFF2F4E3E),
                                                ),
                                                child: Text('Ya, Kembalikan'),
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      if (confirm == true) {
                                        // Tampilkan loading
                                        Get.dialog(
                                          Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          barrierDismissible: false,
                                        );

                                        // Panggil fungsi returnItem
                                        bool success =
                                            await controller.returnItem(
                                                transaksi.id.toString());

                                        // Tutup dialog loading
                                        Get.back();

                                        if (success) {
                                          Get.snackbar(
                                            'Sukses',
                                            'Barang berhasil dikembalikan',
                                            snackPosition: SnackPosition.TOP,
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white,
                                          );
                                        } else {
                                          Get.snackbar(
                                            'Error',
                                            controller.error.value,
                                            snackPosition: SnackPosition.TOP,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                          );
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 6.0,
                                      ),
                                      child: Text(
                                        'Kembalikan Barang',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          controller.formatDate(transaksi.createdAt),
                          style: TextStyle(color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: DashedLine(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Status Order'),
                            Text(
                              transaksi.status == 'pending'
                                  ? 'Pending'
                                  : transaksi.status == 'processing'
                                      ? 'Processing'
                                      : transaksi.status == 'ongoing'
                                          ? 'Ongoing'
                                          : transaksi.status == 'completed'
                                              ? 'Completed'
                                              : transaksi.status == 'cancelled'
                                                  ? 'Cancelled'
                                                  : transaksi.status,
                              style: TextStyle(
                                color: transaksi.status == 'pending'
                                    ? Colors.orange
                                    : transaksi.status == 'ongoing'
                                        ? Colors.blue
                                        : transaksi.status == 'completed'
                                            ? Colors.green
                                            : transaksi.status == 'cancelled'
                                                ? Colors.red
                                                : Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Jumlah Barang'),
                            Text('${transaksi.itemCount} Barang Disewa'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Biaya'),
                            Text(
                              controller.formatCurrency(transaksi.totalAmount),
                              style: TextStyle(
                                color: Color(0xFF2F4E3E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: const MainBottomNav(),
    );
  }
}

class DashedLine extends StatelessWidget {
  final double height;
  final Color color;

  const DashedLine({this.height = 1, this.color = const Color(0xFFBDBDBD)});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashSpace = 3.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}
