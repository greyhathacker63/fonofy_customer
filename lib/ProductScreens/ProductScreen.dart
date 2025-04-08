import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ProductScreen(),
//     );
//   }
// }
//
// // Product Model
// class Product {
//   final String name;
//   final String image;
//   final double price;
//   final double oldPrice;
//   final double rating;
//   final int reviews;
//   final List<Color> availableColors;
//
//   Product({
//     required this.name,
//     required this.image,
//     required this.price,
//     required this.oldPrice,
//     required this.rating,
//     required this.reviews,
//     required this.availableColors,
//   });
// }
//
// // Sample Product Data
// List<Product> products = [
//   Product(
//     name: "Samsung Galaxy M35 5G \n (Thunder Grey, 6GB RAM, 128GB Storage)",
//     image: "assets/images/Phone3.png",
//     price: 14999,
//     oldPrice: 24499,
//     rating: 4.5,
//     reviews: 7657,
//     availableColors: [Colors.grey, Colors.black, Colors.white],
//   ),
//   Product(
//     name: "Samsung Galaxy M35 5G \n (Daybreak Blue, 8GB RAM, 256GB Storage)",
//     image: "assets/images/thumb_3.png",
//     price: 19999,
//     oldPrice: 27999,
//     rating: 4.5,
//     reviews: 7657,
//     availableColors: [Colors.blue, Colors.cyan, Colors.white],
//   ),
//   Product(
//     name: "OnePlus Nord CE 3 Lite 5G \n (Pastel Lime, 8GB RAM, 128GB Storage)",
//     image: "assets/images/thumb_2.png",
//     price: 15656,
//     oldPrice: 18999,
//     rating: 4.2,
//     reviews: 61308,
//     availableColors: [Colors.green, Colors.black, Colors.white],
//   ),
//   Product(
//     name: "realme NARZO 70 Turbo 5G  \n (Turbo Yellow, 6GB RAM, 128GB Storage)",
//     image: "assets/images/main_product.png",
//     price: 16998,
//     oldPrice: 19999,
//     rating: 4.3,
//     reviews: 2591,
//     availableColors: [Colors.yellow, Colors.black, Colors.grey],
//   ),
// ];
//
// class ProductScreen extends StatelessWidget {
//   const ProductScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Products"), backgroundColor: Colors.blue),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // **Product Image (Left Side)**
//                   SizedBox(
//                     width: 120,
//                     child: Image.asset(product.image, height: 120, fit: BoxFit.contain),
//                   ),
//
//                   const SizedBox(width: 12), // Space between image and text
//
//                   // **Product Details (Right Side)**
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Product Name
//                         Text(
//                           product.name,
//                           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//
//                         const SizedBox(height: 6),
//
//                         // Rating & Reviews
//                         Row(
//                           children: [
//                             const Icon(Icons.star, color: Colors.orange, size: 18),
//                             Text(
//                               " ${product.rating} ★ (${product.reviews})",
//                               style: const TextStyle(fontSize: 14, color: Colors.black54),
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(height: 6),
//
//                         // Pricing
//                         Row(
//                           children: [
//                             Text(
//                               "₹${product.price.toStringAsFixed(0)}",
//                               style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
//                             ),
//                             const SizedBox(width: 5),
//                             Text(
//                               "M.R.P: ₹${product.oldPrice.toStringAsFixed(0)}",
//                               style: const TextStyle(
//                                 fontSize: 8,
//                                 color: Colors.grey,
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               "(${((1 - product.price / product.oldPrice) * 100).toStringAsFixed(0)}% off)",
//                               style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(height: 10),
//
//                         // Color Circles
//                         Row(
//                           children: product.availableColors.map((color) {
//                             return Container(
//                               margin: const EdgeInsets.only(right: 8),
//                               width: 20,
//                               height: 20,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: color,
//                                 border: Border.all(color: Colors.black, width: 1),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//
//                         const SizedBox(height: 10),
//
//                         // **Add to Cart Button (Blue)**
//                         SizedBox(
//                           width: 120,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                             child: const Text("Add to Cart", style: TextStyle(color: Colors.white)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:fonofy/Filters/CompareScreen.dart';
import 'package:fonofy/Filters/FilterScreen.dart';
import 'package:fonofy/widgets/Colors.dart';
import 'package:get/get.dart';

import '../Bottom_Sheet/SortBy..dart';

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
  List<Product> selectedProducts = [];
  bool showCheckboxes = false; // Initially, checkboxes are hidden

  void toggleSelection(Product product) {
    setState(() {
      if (selectedProducts.contains(product)) {
        selectedProducts.remove(product);
      } else {
        if (selectedProducts.length < 3) {
          selectedProducts.add(product);
        } else {
          Get.snackbar("Limit Reached", "You can select up to 3 products only",
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    });
  }

  void toggleCompareMode() {
    setState(() {
      showCheckboxes = true; // Show checkboxes when Compare is clicked
    });
  }

  void navigateToCompareScreen() {
    if (selectedProducts.length < 2) {
      Get.snackbar("Select More Products",
          "Please select at least 2 products to compare",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    Get.to(() => CompareScreen(selectedProducts: selectedProducts));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
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
                        sortBy = selectedSort;
                      });
                    });
                  },
                  icon: const Icon(Icons.sort, color: Colors.black),
                  label: const Text("Sort By",
                      style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(width: 8),

                // Filter Button
                OutlinedButton.icon(
                  onPressed: () {
                    Get.to(() => FilterScreen());
                  },
                  icon: const Icon(Icons.tune, color: Colors.black),
                  label: const Text("Filter",
                      style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(width: 8),

                // Compare Button
                OutlinedButton.icon(
                  onPressed: () {
                    if (!showCheckboxes) {
                      toggleCompareMode(); // Show checkboxes first
                    } else {
                      navigateToCompareScreen(); // Proceed if already showing checkboxes
                    }
                  },
                  icon: const Icon(Icons.compare_arrows, color: Colors.black),
                  label: const Text("Compare",
                      style: TextStyle(color: Colors.black)),
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
              final isSelected = selectedProducts.contains(product);
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Product Image
                      SizedBox(
                        width: 100,
                        child: Image.asset(
                          product.image,
                          height: 140,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "₹${product.price.toStringAsFixed(0)}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.green),
                            ),
                            const SizedBox(height: 10),

                            // Add to Cart Button
                            ElevatedButton(
                              onPressed: () {
                                Get.snackbar(
                                  "Added to Cart",
                                  "${product.name} added successfully!",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.appBlueColor3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Add to Cart",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),

                      // Compare Checkbox (Visible only if Compare is clicked)
                      if (showCheckboxes)
                        Column(
                          children: [
                            Checkbox(
                              value: isSelected,
                              onChanged: (_) => toggleSelection(product),
                            ),
                            const Text("Compare",
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}