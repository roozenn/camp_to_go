import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_detail_controller.dart';
import '../routes/app_pages.dart';

class TransactionDetailPage extends StatelessWidget {
  final int orderId;

  const TransactionDetailPage({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionDetailController());

    // Load data saat halaman dibuka
    controller.loadTransactionDetail(orderId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Detail Transaksi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.offAllNamed(Routes.TRANSACTION),
        ),
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
                  onPressed: () => controller.loadTransactionDetail(orderId),
                  child: Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        final detail = controller.transactionDetail.value;
        if (detail == null) {
          return Center(child: Text('Data tidak ditemukan'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail['order_number'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              detail['status'] == 'pending'
                                  ? 'Pending'
                                  : detail['status'] == 'processing'
                                      ? 'Processing'
                                      : detail['status'] == 'completed'
                                          ? 'Completed'
                                          : detail['status'] == 'cancelled'
                                              ? 'Cancelled'
                                              : detail['status'],
                              style: TextStyle(
                                color: detail['status'] == 'pending'
                                    ? Colors.orange
                                    : detail['status'] == 'completed'
                                        ? Colors.green
                                        : detail['status'] == 'cancelled'
                                            ? Colors.red
                                            : Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Items Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail Barang',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        ...(detail['items'] as List)
                            .map((item) => Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            item['product']['image_url'],
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['product']['name'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                  'Jumlah: ${item['quantity']}'),
                                              Text(
                                                  'Tanggal Sewa: ${item['start_date']} - ${item['end_date']}'),
                                              SizedBox(height: 4),
                                              Text(
                                                'Rp ${item['subtotal'].toStringAsFixed(0)}',
                                                style: TextStyle(
                                                  color: Color(0xFF2F4E3E),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Deposit: Rp ${item['deposit_subtotal'].toStringAsFixed(0)}',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (item != detail['items'].last)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: DashedLine(),
                                      ),
                                  ],
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Address Card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alamat Pengiriman',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(detail['address']['recipient_name']),
                          Text(detail['address']['full_address']),
                          Text(detail['address']['phone_number']),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Payment Summary Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ringkasan Pembayaran',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal'),
                            Text(
                                'Rp ${detail['payment_summary']['subtotal'].toStringAsFixed(0)}'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Deposit'),
                            Text(
                                'Rp ${detail['payment_summary']['deposit_total'].toStringAsFixed(0)}'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Diskon'),
                            Text(
                              '- Rp ${detail['payment_summary']['discount_amount'].toStringAsFixed(0)}',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: DashedLine(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Rp ${detail['payment_summary']['total_amount'].toStringAsFixed(0)}',
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
                SizedBox(height: 16),

                // Timeline Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Timeline',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        ...(detail['timeline'] as List)
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF2F4E3E),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['description'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          item['created_at']
                                              .toString()
                                              .split('.')[0]
                                              .replaceAll('T', ' '),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (index != detail['timeline'].length - 1)
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Container(
                                    width: 1,
                                    height: 24,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
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
