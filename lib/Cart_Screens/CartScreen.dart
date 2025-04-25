import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/AddToCartService/AddToCartService.dart';
import 'package:fonofy/Cart_Screens/CheckoutScreen.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:get/get.dart';
import '../model/AddToCartModel/AddToCartModel.dart';
import '../utils/Colors.dart';

class CartScreen extends StatefulWidget {
   final String customerId ;

  const CartScreen({super.key, required this.customerId});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  int quantity = 1;
  final double unitPrice = 25999.0;
  final double shippingCost = 0.0;
  final String productImage = "assets/images/iphone.png";

  // String user_code = "";

  List<AddToCartModel> addToCartItems = [];

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      String? userCode = await TokenHelper.getUserCode();
      if (userCode != null) {
        final response = await AddToCartService().fetchAddToCartData(userCode);
        setState(() {
          addToCartItems = response;
        });
      }
    } catch (e) {
      print("❌ Error fetching cart items: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    if (addToCartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Your Cart", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(child: const Text("Your cart is empty")),
      );
    }

    final item = addToCartItems[0].result;

    double subtotal = unitPrice * quantity;
    double total = subtotal + shippingCost;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "There are ${addToCartItems.length} product(s) in your cart",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            // Product Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(productImage, height: 80, width: 80, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item?.productId.toString() ?? 'No Name', // Display product ID if available
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "₹${unitPrice.toStringAsFixed(1)}", // Display price
                          style: const TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                        const SizedBox(height: 10),
                        // Quantity Selector
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 20),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) quantity--;
                                });
                              },
                            ),
                            Text(quantity.toString(),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add, size: 20),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Remove Button
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        quantity = 0;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Checkout Summary Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  _summaryRow("Subtotal", "₹${subtotal.toStringAsFixed(1)}"),
                  _divider(),
                  _summaryRow("Shipping", "₹${shippingCost.toStringAsFixed(1)}"),
                  _divider(),
                  _summaryRow("Total", "₹${total.toStringAsFixed(1)}", isBold: true),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Proceed to Checkout Button
            ElevatedButton.icon(
              onPressed: () {
                Get.to(() => CheckoutScreen());
                // Navigate to checkout screen
              },
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              label: const Text("Proceed to Checkout", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.appBlueColor3,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
            const SizedBox(height: 10),
            // Continue Shopping Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text("Continue Shopping", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.appBlueColor3,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Divider
  Widget _divider() {
    return const Divider(color: Colors.grey);
  }

  // Summary Row
  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
