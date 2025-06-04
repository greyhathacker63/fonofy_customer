import 'package:flutter/material.dart';
import 'package:fonofy/pages/RepairServiceScreen/RepairServiceScreen.dart';
import 'package:fonofy/widgets/ColorConstants/Colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: YourDeviceScreen4(),
    );
  }
}

class YourDeviceScreen4 extends StatelessWidget {
  const YourDeviceScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Your Device",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Info Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/Phone3.png", height: 80),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("OnePlus 11r 5G", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text("Color: Galactic Silver", style: TextStyle(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFeature(Icons.verified, "Certified Parts"),
                        _buildFeature(Icons.build, "Instant Repair"),
                        _buildFeature(Icons.star, "Trusted Brands"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Repairable Parts
            _buildRepairItem("Screen", "₹8,999", "₹11,250", "-20%", "assets/images/Screen2.png"),
            _buildRepairItem("Battery", "₹2,702", "₹3,377", "-20%", "assets/images/Battery.png"),
            _buildRepairItem("Motherboard", "₹399", "₹500", "-80%", "assets/images/MotherBoard.png", imageSize: 30), // Reduced image size

            const SizedBox(height: 20),

            // Inspection Info
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.green),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    "These are inspection-only charges. Final price will be decided after store inspection. Eligible only at Store Repair.",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Price Summary (Styled)
            _buildPriceSummary(),

            const SizedBox(height: 20),

            // Why Choose Us (Updated with Stats)
            _buildWhyChooseUs(),

            const SizedBox(height: 20),

            // FAQs
            const Text("FAQs", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            _buildFaqItem("How did you calculate my device price?"),
            _buildFaqItem("Is it safe to sell my phone on Fonofy?"),
            _buildFaqItem("How does Voucher Payment work?"),
            const SizedBox(height: 10),
            Center(child: const Text("Load More FAQs", style: TextStyle(fontSize: 14, color: Colors.blue))),
            const Text("By clicking Book Now, You agree with our Terms & Conditions", style: TextStyle(fontSize: 14, color: Colors.black38)),

            const SizedBox(height: 20),

            // Book Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:ColorConstants.appBlueColor3,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Get.to(() => RepairServiceScreen());
                },
                child: const Text("Book Now", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Feature Widget
  Widget _buildFeature(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(height: 5),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // Repair Item Widget with adjustable image size
  Widget _buildRepairItem(String part, String price, String oldPrice, String discount, String imagePath, {double imageSize = 40}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(imagePath, height: imageSize),
          const SizedBox(width: 10),
          Expanded(child: Text(part, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          Text(discount, style: const TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(price, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(width: 5),
          Text(oldPrice, style: const TextStyle(fontSize: 12, color: Colors.black54, decoration: TextDecoration.lineThrough)),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.appBlueColor3, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
            onPressed: () {},
            child: const Text("Add +", style: TextStyle(fontSize: 14, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Styled Price Summary Section
 Widget _buildPriceSummary() {
  return Center(
    child: Container(
      width: Get.width * 0.90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26, width: 1),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Price Summary",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Service Name (Clickable)
          GestureDetector(
            onTap: () {
              // Handle service click
            },
            child: const Text(
              "OnePlus 11r 5G Motherboard Repair",
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Apply Coupon Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Apply Coupon",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              GestureDetector(
                onTap: () {
                  // Handle apply coupon click
                },
                child: const Text(
                  "Apply",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Total Amount Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: ColorConstants.appBlueColor3,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "Saved ₹409",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "₹99",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
  Widget _buildWhyChooseUs() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 3,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align title to the left
        children: [
          // Title: "Why Choose Us?"
          const Padding(
            padding: EdgeInsets.only(bottom: 8), // Space below the title
            child: Text(
              "Why Choose Us?", 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [Image.asset("assets/images/Rupee.png", height: 24), const Text("Pay after service")]),
              Column(children: [Image.asset("assets/images/HomeRepair.png", height: 24), const Text("Home Repair")]),
              Column(children: [Image.asset("assets/images/DataSecurity.png", height: 24), const Text("Data Security")]),
            ],
          ),

          const SizedBox(height: 15),

          // Stats section
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("46K+ Device Repaired", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("4.3+ Rated Products", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildFaqItem(String question) {
    return ListTile(title: Text(question, style: const TextStyle(fontSize: 14)), trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54));
  }
}
