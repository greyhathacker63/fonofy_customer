import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  final List<Map<String, String>> wishlistItems = [
    {
      'image': 'https://m.media-amazon.com/images/I/71ZDY57yTQL._AC_UY218_.jpg',
      'name': 'iPhone 13 (128 GB, Midnight) - Refurbished',
      'price': '₹48,999',
      'originalPrice': '₹69,999',
      'save': 'Save ₹21,000',
    },
    {
      'image': 'https://m.media-amazon.com/images/I/61l9ppRIiqL._AC_UY218_.jpg',
      'name': 'OnePlus Nord CE 2 Lite - Refurbished',
      'price': '₹13,499',
      'originalPrice': '₹19,999',
      'save': 'Save ₹6,500',
    },
    {
      'image': 'https://m.media-amazon.com/images/I/81CgtwSII3L._AC_UY218_.jpg',
      'name': 'Redmi Note 12 5G - Refurbished',
      'price': '₹14,999',
      'originalPrice': '₹21,999',
      'save': 'Save ₹7,000',
    },
    {
      'image': 'https://m.media-amazon.com/images/I/71ZDY57yTQL._AC_UY218_.jpg',
      'name': 'Samsung Galaxy S21 FE 5G - Refurbished',
      'price': '₹29,999',
      'originalPrice': '₹49,999',
      'save': 'Save ₹20,000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Wishlist'),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: wishlistItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.58, // Increased height
          ),
          itemBuilder: (context, index) {
            final item = wishlistItems[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Image
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        item['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                  ),

                  // Info & Button (Scroll-safe)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight),
                              child: IntrinsicHeight(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Product details
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name']!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          item['price']!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.green),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              item['originalPrice']!,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              item['save']!,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    // Button
                                    SizedBox(
                                      width: double.infinity,
                                      height: 36,
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        child: Text('Move to Cart',
                                            style: TextStyle(fontSize: 13)),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.teal,
                                          side: BorderSide(color: Colors.teal),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
