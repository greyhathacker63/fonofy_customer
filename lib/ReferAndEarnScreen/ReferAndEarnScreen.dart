import 'package:flutter/material.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class ReferAndEarnScreen extends StatelessWidget {
  const ReferAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Refer & Earn"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Refer & Earn Container (Main Background Container)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/ReferBanner.png", height: 150),
                  const SizedBox(height: 10),
                  const Text(
                    "Refer & Earn",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "It pays to have a friend!",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Invite your friends and Earn Rs.100 when your friend sells a phone on Fonofy. Your friend also gets Rs.100 extra! (Min transaction value Rs.1500).",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),

                  // Referral Code Box
                  Container(
                    padding: const EdgeInsets.all(15.0),
                     height: Get.height * 0.20,
                     width:Get.width * 0.55,
                    decoration: BoxDecoration(
                      color: ColorConstants.appBlueColor3,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                    children: [
                        const Text(
                          "Your referral code:",
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                        const Text(
                          "QUUPTYE0",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        const Text("Share", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),

                        // Social Media Share Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/facebook.png", height: 30),
                            const SizedBox(width: 10),
                            Image.asset("assets/images/insta.png", height: 30),
                            const SizedBox(width: 10),
                            Image.asset("assets/images/twitter.png", height: 30),
                            const SizedBox(width: 10),
                            Image.asset("assets/images/watsapp.png", height: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // END of Referral Code Box

                  const SizedBox(height: 10),

                  // See My Earnings Section (Now Inside Main Container)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("See My Earnings", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                  const Text("1 Point = 1 INR", style: TextStyle(fontSize: 12, color: Colors.black54)),
                  const Text("Offer Valid till 25 Dec 2025", style: TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            // END of Main Refer & Earn Container

            const SizedBox(height: 20),

            // How It Works Section
            const Text("How Refer & Earn Works", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildReferStep("Login", "Login & we will assign a unique referral code to you", "assets/images/Login2.png"),
            _buildReferStep("Invite", "Share the referral code with your friends & help them sell their phone at the best price", "assets/images/Invite.png"),
            _buildReferStep("Earn", "Earn points equivalent to real money", "assets/images/Earn.png"),

            // FAQs Section
            const SizedBox(height: 20),
            const Text("FAQs", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            _buildFAQ("How did you calculate my device price?"),
            _buildFAQ("Is it safe to sell my phone on Fonofy?"),
            _buildFAQ("How does Voucher Payment work?"),

            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Load More FAQs", style: TextStyle(color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build Refer & Earn steps
  Widget _buildReferStep(String title, String description, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(imagePath, height: 50),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 5),
                Text(description, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to build FAQ items
  Widget _buildFAQ(String question) {
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
