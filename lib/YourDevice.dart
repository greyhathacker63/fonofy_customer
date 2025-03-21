import 'package:flutter/material.dart';
import 'package:fonofy/YourDeviceScreen2.dart';
import 'package:fonofy/widgets/Colors.dart';
import 'package:get/get.dart';

class YourDeviceScreen extends StatelessWidget {
  const YourDeviceScreen({super.key});

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
        title: const Text("Your Device", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Info Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                ],
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/iphone.png",
                      height: 73), // iPhone Image
                  const SizedBox(width: 0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Apple iPhone 6 Plus\n(1 GB/64 GB)",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text(
                              "Selling Price: ",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            const Text(
                              "₹ 3,130",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                // Recalculate Price Action
                              },
                              child: const Text(
                                "Recalculate",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 11,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Features Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _FeatureIcon(icon: Icons.payment, label: "Fast Payments"),
                _FeatureIcon(icon: Icons.local_shipping, label: "Free Pickup"),
                _FeatureIcon(icon: Icons.security, label: "100% Safe"),
              ],
            ),

            const SizedBox(height: 12),

            // Apply Coupons
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: const [
                  Icon(Icons.local_offer, color: Colors.blue),
                  SizedBox(width: 10),
                  Text("Apply Coupons",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.black54),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Special Offers Section
            const Text("Special Offers*",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text("Earn more with these offers and smile wider!",
                style: TextStyle(fontSize: 14, color: Colors.black54)),

            const SizedBox(height: 12),

            // Offer Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _OfferCard(
                    "assets/images/iphone.png", "iPhone Voucher", "₹ 5,340"),
                _OfferCard("assets/images/amazon.png", "Amazon Pay Gift Card",
                    "₹ 5,340"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _OfferCard("assets/images/flipkart.png", "Flipkart Gift Card",
                    "₹ 5,340"),
                _OfferCard("assets/images/croma.png", "Croma", "₹ 5,340"),
              ],
            ),

            const SizedBox(height: 12),

            // WhatsApp Toggle
            Row(
              children: [
                const Expanded(
                    child: Text("Get price alerts & updates on Whatsapp",
                        style: TextStyle(fontSize: 14))),
                Switch(
                    value: true,
                    activeColor: ColorConstants.appBlueColor3,
                    onChanged: (bool value) {}),
              ],
            ),

            const SizedBox(height: 12),

            // FAQs Section
// FAQs Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16), // Proper padding
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items to left
                children: [
                  const Text(
                    "FAQs",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10), // Space after title
                  Align(
                    alignment: Alignment.centerLeft, // Align items to left
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FAQItem("How did you calculate my device price?"),
                        _FAQItem("Is it safe to sell my phone on Fonofy?"),
                        _FAQItem("How does Voucher Payment work?"),
                        const SizedBox(
                            height: 6), // Space before "Load More FAQs"
                      ],
                    ),
                  ),

                  const Text(
                    "Load More FAQs",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Bottom Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("₹ 5,340",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const Text("View Breakups",
                          style: TextStyle(fontSize: 14, color: Colors.blue)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {

                      Get.to(() => YourDeviceScreen2());
                      // Sell Now Action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.appBlueColor3,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                    child: const Text("Sell Now",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 30),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _OfferCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final String price;

  const _OfferCard(this.imagePath, this.label, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 20,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Image.asset(imagePath, height: 40), // Offer Logo
          const SizedBox(height: 10),
          Text(label,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          Text(price,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ],
      ),
    );
  }
}

class _FAQItem extends StatelessWidget {
  final String question;

  const _FAQItem(this.question);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(question, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 16, color: Colors.black54),
        ),
        Divider(color: Colors.grey.shade300),
      ],
    );
  }
}
