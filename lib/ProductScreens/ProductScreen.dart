import 'package:flutter/material.dart';
import 'package:fonofy/Bottom_Sheet/SortBy.dart';
import 'package:fonofy/Filters/Filter.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),
    );
  }
}

// Product Model
class Product {
  final String name;
  final String image;
  final double price;
  final double oldPrice;
  final double rating;
  final int reviews;
  final List<Color> availableColors;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.reviews,
    required this.availableColors,
  });
}

// Sample Product Data
List<Product> products = [
  Product(
    name: "Samsung Galaxy M35 5G \n (Thunder Grey, 6GB RAM, 128GB Storage)",
    image: "assets/images/Phone3.png",
    price: 14999,
    oldPrice: 24499,
    rating: 4.5,
    reviews: 7657,
    availableColors: [Colors.grey, Colors.black, Colors.white],
  ),
  Product(
    name: "Samsung Galaxy M35 5G \n (Daybreak Blue, 8GB RAM, 256GB Storage)",
    image: "assets/images/thumb_3.png",
    price: 19999,
    oldPrice: 27999,
    rating: 4.5,
    reviews: 7657,
    availableColors: [Colors.blue, Colors.cyan, Colors.white],
  ),
  Product(
    name: "OnePlus Nord CE 3 Lite 5G \n (Pastel Lime, 8GB RAM, 128GB Storage)",
    image: "assets/images/thumb_2.png",
    price: 15656,
    oldPrice: 18999,
    rating: 4.2,
    reviews: 61308,
    availableColors: [Colors.green, Colors.black, Colors.white],
  ),
  Product(
    name: "realme NARZO 70 Turbo 5G  \n (Turbo Yellow, 6GB RAM, 128GB Storage)",
    image: "assets/images/main_product.png",
    price: 16998,
    oldPrice: 19999,
    rating: 4.3,
    reviews: 2591,
    availableColors: [Colors.yellow, Colors.black, Colors.grey],
  ),
];

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String sortBy = "None";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Filter Options
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Sort By Button
                  OutlinedButton.icon(
                    onPressed: () {
                      showSortBySheet(context, (selectedSort) {
                        setState(() {
                          sortBy = selectedSort; // Update selected sort option
                        });
                      });
                    },
                    icon: const Icon(Icons.sort, color: Colors.black),
                    label: const Text("Sort By",
                        style: TextStyle(color: Colors.black)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Filter Button
                  OutlinedButton.icon(
                    onPressed: () {
                      Get.to(() => FilterScreen());
                      // Implement Filter functionality here
                    },
                    icon: const Icon(Icons.tune, color: Colors.black),
                    label: const Text("Filter",
                        style: TextStyle(color: Colors.black)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Compare Button
                  OutlinedButton.icon(
                    onPressed: () {
                      // Implement Compare functionality here
                    },
                    icon: const Icon(Icons.compare_arrows, color: Colors.black),
                    label: const Text("Compare",
                        style: TextStyle(color: Colors.black)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Product List
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Image.asset(product.image,
                              height: 120, fit: BoxFit.contain),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.orange, size: 18),
                                  Text(
                                      " ${product.rating} ★ (${product.reviews})"),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text("₹${product.price.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 8),
                                  Text(
                                      "M.R.P: ₹${product.oldPrice.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: product.availableColors.map((color) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: color,
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 120,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  child: const Text("Add to Cart",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
