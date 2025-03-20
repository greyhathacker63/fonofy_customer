import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RepairScreen extends StatefulWidget {
  const RepairScreen({super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
  int _currentIndex = 0; 

  final List<String> demoImages = [
    "assets/images/banner.png",
    "assets/images/banner.png",
    "assets/images/banner.png",
    "assets/images/banner.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                "assets/images/repairbanner.png",
                height: Get.height * 0.18,
                fit: BoxFit.contain,
                width: double.infinity, // Fixed width
              ),
            ),

            topBrands(brands: [
              {"imagePath": "assets/images/oppo.png", "brandName": 'Oppo'},
              {
                "imagePath": "assets/images/applephone.png",
                "brandName": 'Apple'
              },
              {"imagePath": "assets/images/mi.png", "brandName": 'Mi'},
              {"imagePath": "assets/images/vivo.png", "brandName": 'Vivo'},
              {"imagePath": "assets/images/xiomi.png", "brandName": 'Xiomi'},
              {
                "imagePath": "assets/images/samsung.png",
                "brandName": 'Samsung'
              },
              {
                "imagePath": "assets/images/applephone.png",
                "brandName": 'Apple'
              },
              {
                "imagePath": "assets/images/samsung.png",
                "brandName": 'Samsung'
              },
            ]),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _processStep(1, "Check Price",
                      "Select your device & tell us about its current condition, and our advanced AI tech will tailor..."),
                  const SizedBox(height: 12),
                  _processStep(2, "Schedule Pickup",
                      "Book a free pickup from your home or work at a time slot that..."),
                  const SizedBox(height: 12),
                  _processStep(3, "Get Paid",
                      "Did we mention you get paid as soon as our executive picks up your device?"),
                ],
              ),
            ),

            // WHY US SECTION
            Container(
              color: Colors.blue.shade50,
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "WHY US",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: [
                      _whyUsCard(
                          "assets/images/costsavings.png",
                          "Cost Savings",
                          "Refurbished devices are often significantly cheaper.."),
                      _whyUsCard(
                          "assets/images/warrantly&support.png",
                          "Warranty And Support",
                          "All refurbished devices come with warranties and customer..."),
                      _whyUsCard(
                          "assets/images/ecofriendly.png",
                          "Eco-Friendly",
                          "Purchasing refurbished electronics helps reduce electronic waste.."),
                      _whyUsCard(
                          "assets/images/wideSelection.png",
                          "Wide Selection",
                          "You can find a variety of models and brands, including some that might no longer..."),
                      _whyUsCard(
                          "assets/images/qualityassurance.png",
                          "Quality Assurance",
                          "Reputable platforms like Fonofy typically ensure..."),
                      _whyUsCard(
                          "assets/images/freedomofchoice.png",
                          "Freedom Of Choice",
                          "Refurbished phones give you freedom to switch phones in regular interval"),
                    ],
                  ),
                ],
              ),
            ),

            // SERVICE AVAILABLE (Added after WHY US)
            serviceAvailable(),

            // TESTIMONIAL SECTION
            Container(
              color: Colors.blue.shade900,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "WHAT OUR CLIENT SAYS",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  CarouselSlider.builder(
                    itemCount: demoImages.length,
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      aspectRatio: 2.5,
                      initialPage: 2,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return testimonialCard(
                        name: "Jane Doe",
                        role: "CEO, Example Company",
                        text:
                            "\"Some quick example text to build on the card title and make up the bulk of the card's content.\"",
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: demoImages.asMap().entries.map((entry) {
                      return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == entry.key
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

  Widget topBrands({required List<Map<String, String>> brands}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Top Brands",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const SizedBox(height: 8),

        // Grid View for Brands
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Disable grid scrolling
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns per row
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.2, // Adjust this based on your design
          ),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                // Brand Image
                Container(
                  // height: Get.height * 0.10,
                  height: 70,
                  width: Get.width * 0.30,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: ClipRect(
                    child: Image.asset(
                      brands[index]['imagePath']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // Brand Name
                Text(
                  brands[index]['brandName']!,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

// Process Step Widget
  Widget _processStep(int number, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 14,
          child: Text("$number",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text(description,
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }

// Why Us Card Widget
  Widget _whyUsCard(String iconPath, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(iconPath, height: 32, width: 32),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          Text(description,
              style: const TextStyle(fontSize: 10, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget testimonialCard(
      {required String name, required String role, required String text}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(radius: 30, backgroundColor: Colors.grey),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                role,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10), 
      ],
    );
  }

  Widget serviceAvailable() {
    List<Map<String, String>> services = [
      {"iconPath": "assets/images/screen.png", "serviceName": "Screen"},
      {"iconPath": "assets/images/batter.png", "serviceName": "Battery"},
      {"iconPath": "assets/images/mic.png", "serviceName": "Mic"},
      {"iconPath": "assets/images/receiver.png", "serviceName": "Receiver"},
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SERVICE AVAILABLE",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: services.map((service) {
              return Container(
                width: 80,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(service["iconPath"]!,
                        height: 40), // Add your icons
                    const SizedBox(height: 8),
                    Text(
                      service["serviceName"]!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

