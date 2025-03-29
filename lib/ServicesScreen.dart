import 'package:flutter/material.dart';
import 'package:fonofy/SellScreen/SellScreen.dart';
import 'package:get/get.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Services"),
        leading: const Icon(Icons.arrow_back),
        actions: [const Icon(Icons.favorite_border)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategory("Sell for cash", [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => Sellscreen()); // Navigate to SellScreen
                  },
                  child: _buildServiceItem(
                      "Sell Phone", "assets/images/phone.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: _buildServiceItem(
                    "Sell Laptop", "assets/images/Laptop.png"),
              ),
            ]),
            _buildCategory("Buy Refurbished", [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: _buildServiceItem("Refurbished Phones",
                    "assets/images/refurbished_phone.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: _buildServiceItem("Refurbished Laptops",
                    "assets/images/refurbished_laptop.png"),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildCategory("Other", [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildServiceItem(
                      "Repair Phone", "assets/images/Repair_phone.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      _buildServiceItem("Recycle", "assets/images/recycle.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildServiceItem(
                      "Nearby Stores", "assets/images/nearby.png"),
                ),
              ]),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
                "REFURBISHED DEVICE",
                "Start Your Journey Towards Fonofy.\nYou can buy your dream phone at almost half price.",
                "assets/images/RefurbishedDevice.png", [
              "64+ Points Quality Checks",
              "6 Months Assured Warranty",
              "Door step Service",
            ]),
            _buildInfoCard(
                "OLD DEVICE",
                "We give you yourself a chance to upgrade.\nGift Your Device a New Home",
                "assets/images/OldDevice.png", [
              "Get Best Price of your Device",
              "We will provide Best Exchange/Sell Value.",
              "Avail Doorstep Pickup",
            ]),
            _buildInfoCard(
                "LAPTOP & TABLET",
                "With my laptop in hand, the world becomes my digital playground.",
                "assets/images/Laptop&Tablet.png", [
              "64+ Points Quality Checks",
              "3 Months Assured Warranty",
              "Door step Service",
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Wrap(spacing: 10, runSpacing: 10, children: items),
      ],
    );
  }

  Widget _buildServiceItem(String title, String imagePath) {
    return Column(
      children: [
        Image.asset(imagePath, height: 80),
        const SizedBox(height: 5),
        Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildInfoCard(String title, String description, String iconPath,
      List<String> features) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(iconPath, height: 40),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features
                  .map((feature) =>
                      Text("• $feature", style: const TextStyle(fontSize: 12)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
