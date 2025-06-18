import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilter;
  final Map<String, dynamic> currentFilters;

  const FilterDialog({
    super.key,
    required this.onApplyFilter,
    required this.currentFilters,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? selectedCategory;
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;
  late double minPrice;
  late double maxPrice;

  final List<String> categories = [
    'Tenda',
    'Alat Tidur',
    'Masak',
    'Sepatu',
    'Tas',
  ];

  @override
  void initState() {
    super.initState();

    // Initialize with current filters
    selectedCategory = widget.currentFilters['category'];

    minPrice = widget.currentFilters['minPrice']?.toDouble() ?? 0.0;
    maxPrice = widget.currentFilters['maxPrice']?.toDouble() ?? 0.0;

    minPriceController = TextEditingController(
      text: minPrice > 0 ? minPrice.toStringAsFixed(0) : '',
    );
    maxPriceController = TextEditingController(
      text: maxPrice > 0 ? maxPrice.toStringAsFixed(0) : '',
    );
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  void _updateMinPrice(double value) {
    setState(() {
      minPrice = value;
      minPriceController.text = value.toStringAsFixed(0);
    });
  }

  void _updateMaxPrice(double value) {
    setState(() {
      maxPrice = value;
      maxPriceController.text = value.toStringAsFixed(0);
    });
  }

  void _applyFilter() {
    final filters = {
      'category': selectedCategory,
      'minPrice': minPrice > 0 ? minPrice : null,
      'maxPrice': maxPrice > 0 ? maxPrice : null,
    };

    widget.onApplyFilter(filters);
    Get.back();
  }

  void _resetFilter() {
    setState(() {
      selectedCategory = null;
      minPrice = 0.0;
      maxPrice = 0.0;
      minPriceController.clear();
      maxPriceController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Produk',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Categories Section
            const Text(
              'Kategori',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: categories.map((category) {
                return RadioListTile<String>(
                  title: Text(category),
                  value: category,
                  groupValue: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Price Range Section
            const Text(
              'Rentang Harga',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // Min Price
            Row(
              children: [
                const Text(
                  'Min: ',
                  style: TextStyle(fontSize: 14),
                ),
                Expanded(
                  child: TextField(
                    controller: minPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: 'Rp ',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onChanged: (value) {
                      final price = double.tryParse(value);
                      if (price != null) {
                        _updateMinPrice(price);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _updateMinPrice(
                      (minPrice - 10000).clamp(0, double.infinity)),
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: () => _updateMinPrice(minPrice + 10000),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Max Price
            Row(
              children: [
                const Text(
                  'Max: ',
                  style: TextStyle(fontSize: 14),
                ),
                Expanded(
                  child: TextField(
                    controller: maxPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: 'Rp ',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onChanged: (value) {
                      final price = double.tryParse(value);
                      if (price != null) {
                        _updateMaxPrice(price);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _updateMaxPrice(
                      (maxPrice - 10000).clamp(0, double.infinity)),
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: () => _updateMaxPrice(maxPrice + 10000),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetFilter,
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyFilter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F4E3E),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Terapkan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
