import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/ViewScreen/AllBrands.dart';
import 'package:fonofy/RepairScreen/RepairScreen.dart';

import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class Sellscreen extends StatefulWidget {
  const Sellscreen({super.key});

  @override
  State<Sellscreen> createState() => _SellscreenState();
}

class _SellscreenState extends State<Sellscreen> {
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
            // Banner Image
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset("assets/images/banner.png",
                  height: 120, fit: BoxFit.cover),
            ),
            sellDevice(
                imagePath: "assets/images/phone.png",
                text1: "Sell this device"),

            sellForCash(
              brands: [
                {
                  "brandName": "Apple",
                  "imagePath": "assets/images/applephone.png"
                },
                {
                  "brandName": "Samsung",
                  "imagePath": "assets/images/samsung.png"
                },
                {"brandName": "Xiaomi", "imagePath": "assets/images/xiomi.png"},
                {"brandName": "Vivo", "imagePath": "assets/images/vivo.png"},
                {"brandName": "Oppo", "imagePath": "assets/images/oppo.png"},
                {
                  "brandName": "Realme",
                  "imagePath": "assets/images/realme.png"
                },
                {
                  "brandName": "Lenovo",
                  "imagePath": "assets/images/Lenovo.png"
                },
              ],
            ),

            // Featured Categories Section
            // Featured Categories Section
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.03), // Responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Featured Categories",
                    style: TextStyle(
                      fontSize: Get.width * 0.045, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.015), // Responsive spacing
                  featuredCategory(categories: [
                    {
                      "imagePath": "assets/images/Deal.png",
                      "text1": "Deal of the day"
                    },
                    {
                      "imagePath": "assets/images/refurbished.png",
                      "text1": "Refurbished Mobiles"
                    },
                    {
                      "imagePath": "assets/images/AppleMobiles.png",
                      "text1": "Apple Mobiles"
                    },
                    {
                      "imagePath": "assets/images/oneplus.png",
                      "text1": "OnePlus Offer"
                    },
                  ]),
                ],
              ),
            ),

            SizedBox(height: Get.height * 0.03), // Responsive spacing

            // Other Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Other",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ("Repair Phone" == "Repair Phone") {
                            Get.to(() => RepairScreen());
                          }
                        },
                        child: featureCard(
                          imagePath: "assets/images/phone.png",
                          label: "Repair Phone",
                        ),
                      ),
                      featureCard(
                          imagePath: "assets/images/recycle.png",
                          label: "Recycle"),
                      featureCard(
                          imagePath: "assets/images/nearby.png",
                          label: "Nearby Stores"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

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

  featureCard({required String imagePath, required String label}) {
    return Column(
      children: [
        Image.asset(imagePath, height: 50),
        const SizedBox(height: 5),
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  categoryCard({required String imagePath, required String label}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
          ),
          child: Image.asset(imagePath, height: 40),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget sellDevice({String? imagePath, String? text1}) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.grey,
                    child: Image.asset(
                      imagePath!,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text1!,
                        style: TextStyle(color: Colors.blue, fontSize: 10),
                      ),
                      Text(
                        "Phone Name",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                      Text(
                        "Get 30,500",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => AllBrandsScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.appBlueColor3,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Sell Now",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Featured Category Widget
  Widget featuredCategory({required List<Map<String, String>> categories}) {
    return SizedBox(
      height: Get.height * 0.18, // Responsive height
      width: Get.width, // Full width
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(Get.width * 0.02), // Responsive padding
            child: Container(
              padding: EdgeInsets.all(Get.width * 0.025),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(Get.width * 0.03),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    categories[index]["imagePath"]!,
                    height: Get.height * 0.08,
                    width: Get.width * 0.18,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                      height: Get.height * 0.01),
                  SizedBox(
                    width: Get.width * 0.18, // Responsive text width
                    child: Text(
                      categories[index]["text1"]!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Get.width * 0.03, // Responsive font size
                      ),
                      textAlign: TextAlign.center, // Centered text
                      maxLines: 2, // Prevents text overflow
                      overflow: TextOverflow.ellipsis, // Adds "..." if too long
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget testimonialCard(
      {required String name, required String role, required String text}) {
    return Container(
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
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            role,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

Widget sellForCash({required List<Map<String, String>> brands}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "SELL FOR CASH",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 10),

      // GridView for brands
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 4 columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8, // Adjusts item height
          ),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to AllBrandsScreen on tap
                Get.to(() => AllBrandsScreen());
              },
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
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
                  Text(
                    brands[index]['brandName']!,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}
