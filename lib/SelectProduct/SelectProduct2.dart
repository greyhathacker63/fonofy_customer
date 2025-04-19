import 'package:flutter/material.dart';
import 'package:fonofy/Device/DeviceDetailsScreen.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class SelectProduct2 extends StatelessWidget {
  const SelectProduct2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Select Product", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        
       
        child: Column(
         
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/Phone3.png", height: 80), // Replace with actual phone image
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Apple iPhone 6 Plus\n(1 GB/64 GB)",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                        ),
                        const SizedBox(height: 5),
                        const Text("Get Upto", style: TextStyle(color: Colors.black54)),
                        const Text(
                          "₹ 3,130",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "7400+ already sold on Fonofy",
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Price Disclaimer
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                "The price stated above depends on the condition of the product and is not final. "
                "The final price offer will be quoted at the end of the diagnosis.",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),

            const SizedBox(height: 15),

            // New Phone Offer
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/Iphone2.png", height: 50), // Replace with actual image
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Purchasing New iPhone?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Get upto ₹4000* Bonus & avail it at various stores",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Special Offers
            const Text("Special Offer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  _buildOfferRow("assets/images/instantBank.png", "Instant bank transfer"),
                  _buildOfferRow("assets/images/GiftCard.png", "Get 3.5% Extra Amazon Pay Gift Card"),
                  _buildOfferRow("assets/images/FlipkartGiftCard.png", "Get 3.5% Extra Flipkart Gift Card"),
                  _buildOfferRow("assets/images/VoucherCroma.png", "Get 1% Extra with this voucher Croma"),
                  _buildOfferRow("assets/images/UPI.png", "UPI"),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // FAQs
            const Text("FAQs", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            _buildFaqItem("How did you calculate my device price?"),
            _buildFaqItem("Is it safe to sell my phone on Fonofy?"),
            _buildFaqItem("How does Voucher Payment work?"),

            const SizedBox(height: 10),

            // Load More FAQs
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Load More FAQs", style: TextStyle(color: Colors.blue)),
              ),
            ),

            const SizedBox(height: 10),

            // Get Exact Value Button
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor:ColorConstants.appBlueColor3,
      padding: const EdgeInsets.symmetric(vertical: 12),
    ),
    onPressed: () {
      Get.to(() => DeviceDetailsScreen()); // ✅ Navigate to DeviceDetailsScreen
    },
    child: const Text(
      "Get Exact Value",
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  ),
),
          ]
        ),
      ),
    );
  }

  // Function to build special offer row
  Widget _buildOfferRow(String iconPath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Image.asset(iconPath, height: 20), // Replace with actual icon
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  // Function to build FAQ item
  Widget _buildFaqItem(String question) {
    return Column(
      children: [
        ListTile(
          title: Text(question, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.keyboard_arrow_down),
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
