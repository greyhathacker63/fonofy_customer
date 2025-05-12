import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../bottom_navgation.dart';

class OrderThankYouScreen extends StatelessWidget {
  final String orderId;
  const OrderThankYouScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_rounded, color: Colors.green, size: 100),
                const SizedBox(height: 20),
                const Text(
                  "Thank You!",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Your order has been placed successfully.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),   Text("OrderID: $orderId",
            style: TextStyle(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
          ),

                const SizedBox(height: 10),
                 const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                   Get.to(()=> BottomNavigation(upperTabIndex:  0,));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Continue Shopping",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
