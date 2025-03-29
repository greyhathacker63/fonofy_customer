import 'package:flutter/material.dart';
import 'package:fonofy/widgets/Colors.dart';

class OrderScreen2 extends StatelessWidget {
  const OrderScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Buy, Sell, Repair Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton("BUY"),
                _buildButton("SELL"),
                _buildButton("REPAIR"),
              ],
            ),
            const SizedBox(height: 50),

            // No Orders Found Image
            Image.asset(
              "assets/images/no_orders.png",
              width: 250,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),

            const Text(
              "No Orders Found",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 8),

            const Text(
              "Repair Your Old Phone With Free Doorstep\nTechnician Visit",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                print("Browse Now Clicked");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.appBlueColor3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                "BROWSE NOW",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create buttons (BUY, SELL, REPAIR)
  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () {
        print("$text clicked");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.appBlueColor3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
