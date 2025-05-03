import 'package:flutter/material.dart';

class ListingPage extends StatelessWidget {
  const ListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.search, color: Colors.grey),
                          ),
                          const Text(
                            'Forclaz MT900',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.sort, size: 20),
                            onPressed: () {},
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {},
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),

            // Result count and filter
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '145 Hasil',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Tenda',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Product grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  // Return different tent designs based on index
                  return TentCard(
                    imageUrl: 'assets/tent${index % 3 + 1}.jpg',
                    name: 'Forclaz Men\'s MT900 Symbium2',
                    rating: 4,
                    price: 'Rp76.000/hari',
                    originalPrice: 'Rp100.000/hari',
                    discount: '24%',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TentCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int rating;
  final String price;
  final String originalPrice;
  final String discount;

  const TentCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.price,
    required this.originalPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Container(
                color: Colors.grey[200],
                width: double.infinity,
                child: getTentImage(imageUrl),
              ),
            ),
          ),
          // Product details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ...List.generate(
                      rating,
                      (index) =>
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                    ),
                    ...List.generate(
                      5 - rating,
                      (index) =>
                          Icon(Icons.star, color: Colors.grey[300], size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      originalPrice,
                      style: TextStyle(
                        color: Colors.grey[500],
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      discount,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to select different tent images based on index
  Widget getTentImage(String url) {
    // Since we can't load actual images in this example, we'll create tent-like shapes
    int imageIndex = int.parse(url.substring(url.length - 5, url.length - 4));

    switch (imageIndex) {
      case 1:
        return Container(
          color: Colors.blue[200],
          child: Center(
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue[800]!),
              ),
            ),
          ),
        );
      case 2:
        return Container(
          color: Colors.black26,
          child: Center(
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.amber[100],
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
        );
      default:
        return Container(
          color: Colors.teal[100],
          child: Center(
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.teal),
              ),
            ),
          ),
        );
    }
  }
}
