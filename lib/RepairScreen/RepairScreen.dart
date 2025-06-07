
import 'package:flutter/material.dart';
import 'package:fonofy/controllers/RepairController/RepairTestimonialListController.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../controllers/SellControllers/BrandListControllers.dart';
import '../controllers/RepairController/RepairBrandListController.dart';
import '../controllers/SellControllers/SellTestimonialListControllers.dart';
import '../widgets/RepairWidets/serviceAvailable.dart';
import '../widgets/RepairWidets/testimonialCard.dart';
import '../widgets/RepairWidets/topBrands.dart';

class RepairScreen extends StatefulWidget {
  const RepairScreen({super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {

  final RepairBrandListController repairBrandListController = Get.put(RepairBrandListController());

 final RepairTestimonialController repairTestimonialController = Get.put(RepairTestimonialController());


  int _currentIndex = 0;

  final List<String> demoImages = [
    "assets/images/banner.png",
    "assets/images/banner.png",

  ];
  @override
  void initState() {
    super.initState();
    repairBrandListController.getRepairBrandListData();
    repairTestimonialController.getTestimonialRepairListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.all(12.0),
              child: Image.asset("assets/images/repairbanner.png",
                height: Get.height * 0.18,
                fit: BoxFit.contain,
                width: double.infinity, // Fixed width
              ),
            ),
            // topBrands(brands: [
            //   {"imagePath": "assets/images/oppo.png", "brandName": 'Oppo'},
            //   {
            //     "imagePath": "assets/images/applephone.png",
            //     "brandName": 'Apple'
            //   },
            //   {"imagePath": "assets/images/mi.png", "brandName": 'Mi'},
            //   {"imagePath": "assets/images/vivo.png", "brandName": 'Vivo'},
            //   {"imagePath": "assets/images/xiomi.png", "brandName": 'Xiomi'},
            //   {
            //     "imagePath": "assets/images/samsung.png",
            //     "brandName": 'Samsung'
            //   },
            //   {
            //     "imagePath": "assets/images/applephone.png",
            //     "brandName": 'Apple'
            //   },
            //   {
            //     "imagePath": "assets/images/samsung.png",
            //     "brandName": 'Samsung'
            //   },
            // ]),
            Obx(() {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: double.infinity,
                child: repairBrandListController.isRepairListLoading.value
                    ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
                    : repairBrandListController.brandListRepair.isEmpty
                    ? const Center(
                  child: Text('No brands available',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
                    : topBrands(repairBrandListController.brandListRepair),
              );
            }),

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
                    physics:   NeverScrollableScrollPhysics(),
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
            serviceAvailable(),
             Container(
              color: Colors.blue.shade900,
              padding:   EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text("WHAT OUR CLIENT SAYS",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                   SizedBox(height: 15),
                  // CarouselSlider.builder(
                  //   itemCount: demoImages.length,
                  //   options: CarouselOptions(
                  //     height: 250,
                  //     autoPlay: false,
                  //     enlargeCenterPage: true,
                  //     viewportFraction: 1,
                  //     aspectRatio: 2.5,
                  //     initialPage: 2,
                  //     onPageChanged: (index, reason) {
                  //       setState(() {
                  //         _currentIndex = index;
                  //       });
                  //     },
                  //   ),
                  //   itemBuilder: (context, index, realIndex) {
                  //     return testimonialCard(
                  //       name: "Jane Doe",
                  //       role: "CEO, Example Company",
                  //       text:
                  //           "\"Some quick example text to build on the card title and make up the bulk of the card's content.\"",
                  //     );
                  //   },
                  // ),
                  //  SizedBox(height: 8),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: demoImages.asMap().entries.map((entry) {
                  //     return Container(
                  //       width: 8,
                  //       height: 8,
                  //       margin: const EdgeInsets.symmetric(
                  //           vertical: 5, horizontal: 4),
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: _currentIndex == entry.key
                  //             ? Colors.blueAccent
                  //             : Colors.grey,
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 250,
                    child: Obx(() {
                      final isLoading = repairTestimonialController.isTestimonialListRepairLoading.value;
                      final testimonialsTop = repairTestimonialController.testimonialRepairListData;
                      if (isLoading == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,color: Colors.blue,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      }
                      if (testimonialsTop.isEmpty) {
                        return const Center(
                          child: Text(
                            'No testimonials available',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        );
                      }
                      return CarouselSlider.builder(
                        itemCount: testimonialsTop.length,
                        options: CarouselOptions(
                          height: 250,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          aspectRatio: 2.5,
                          initialPage: 0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        itemBuilder: (context, index, realIndex) {
                          final testimonial = testimonialsTop[index];
                          // final imageUrl = "$imageBrandBaseUrl${testimonial.image ?? ''}".replaceAll('//', '/');
                          // debugPrint('Testimonial image URL: $imageUrl');
                          return testimonialCard(
                            name: testimonial.name ?? '',
                            image: testimonial.image ?? '',
                            text: testimonial.description ?? '',
                          );
                        },
                      );
                    }),
                  ),
                   SizedBox(height: 8),
                  Obx(() {
                    final testimonialsDetails = repairTestimonialController.testimonialRepairListData;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(testimonialsDetails.length, (index) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                          ),
                        );
                      }),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
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



