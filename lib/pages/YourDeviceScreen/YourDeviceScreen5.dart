import 'package:flutter/material.dart';
import 'package:fonofy/widgets/ColorConstants/Colors.dart';

class YourDeviceScreen5 extends StatelessWidget {
  const YourDeviceScreen5 ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Your Device",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/inconvenience.png", 
                    height: 120,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "We're Sorry",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Your device seems to have very little value due to its condition",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Get price alerts & updates on WhatsApp",
                  style: TextStyle(fontSize: 14),
                ),
                Switch(
                  value: true,
                  activeColor: ColorConstants.appBlueColor3, 
                  onChanged: (bool value) {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // FAQs
            const Text(
              "FAQs",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            _buildFaqTile("How did you calculate my device price?"),
            _buildFaqTile("Will I get the same device price as offered?"),
            _buildFaqTile("How does Voucher payment work?"),

            const SizedBox(height: 8),

            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Load More FAQs",
                  style: TextStyle(
                    color: ColorConstants.appBlueColor3, 
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Sell Another Device Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.appBlueColor3, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "SELL ANOTHER DEVICE →",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Reusable FAQ Expansion Tile
  Widget _buildFaqTile(String title) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.add),
          onTap: () {},
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
