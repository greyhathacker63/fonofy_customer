
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/ViewScreen/AllBrands.dart';
import 'package:fonofy/RepairScreen/RepairScreen.dart';
import 'package:fonofy/controllers/SellControllers/BrandListControllers.dart';
import 'package:fonofy/controllers/SellControllers/SellTestimonialListControllers.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';
import '../widgets/SellWidgets/sellForCash.dart';

class Sellscreen extends StatefulWidget {
  const Sellscreen({super.key});

  @override
  State<Sellscreen> createState() => _SellscreenState();
}

class _SellscreenState extends State<Sellscreen> {

   final BrandListController brandListController = Get.put(BrandListController());
  final  TestimonialListController testimonialListController = Get.put(TestimonialListController());

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    brandListController.getBrandListData();
    testimonialListController.getTestimonialListData();
  }




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
              child: Image.asset(
                "assets/images/banner.png",
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            sellDevice(
              imagePath: "assets/images/phone.png",
              text1: "Sell this device",
            ),

            // Sell for Cash Section
            Obx(() {
              return SizedBox(
                height: Get.height * 0.8,
                width: double.infinity,
                child: brandListController.isBrandListLoading.value
                    ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
                    : brandListController.brandList.isEmpty
                    ? const Center(
                  child: Text('No brands available',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
                    : sellForCash(brandListController.brandList),
              );
            }),

            // Featured Categories Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Featured Categories",
                    style: TextStyle(
                      fontSize: Get.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.015),
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
                  ]),
                ],
              ),
            ),

            SizedBox(height: Get.height * 0.03),

            // Other Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Other",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => RepairScreen()),
                        child: featureCard(
                          imagePath: "assets/images/phone.png",
                          label: "Repair Phone",
                        ),
                      ),
                      featureCard(
                        imagePath: "assets/images/recycle.png",
                        label: "Recycle",
                      ),
                      featureCard(imagePath: "assets/images/nearby.png", label: "Nearby Stores",
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Testimonial Section
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
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 250,
                    child: Obx(() {
                      final isLoading = testimonialListController.isTestimonialListLoading.value;
                      final testimonials = testimonialListController.testimonialListData;
                      if (isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      }
                      if (testimonials.isEmpty) {
                        return const Center(
                          child: Text(
                            'No testimonials available',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        );
                      }
                      return CarouselSlider.builder(
                        itemCount: testimonials.length,
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
                          final testimonial = testimonials[index];
                          // final imageUrl = "$imageBrandBaseUrl${testimonial.image ?? ''}".replaceAll('//', '/');
                          // debugPrint('Testimonial image URL: $imageUrl');
                          return testimonialCard(
                            name: testimonial.name ?? 'Unknown',
                            image: testimonial.image ?? '',
                            text: testimonial.description ?? 'No description',
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    final testimonials = testimonialListController.testimonialListData;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(testimonials.length, (index) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin:   EdgeInsets.symmetric(vertical: 5, horizontal: 4),
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

  // Feature Card Widget
  Widget featureCard({required String imagePath, required String label}) {
    return Column(
      children: [
        Image.asset(imagePath, height: 50),
        const SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // Sell Device Widget
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    color: Colors.grey,
                    child: Image.asset(
                      imagePath!,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text1!,
                        style: const TextStyle(color: Colors.blue, fontSize: 10),
                      ),
                       Text("Phone Name",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                       Text(
                        "Get 30,500",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => Get.to(() => AllBrandsScreen()),
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
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
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

  // Featured Category Widget
  Widget featuredCategory({required List<Map<String, String>> categories}) {
    return SizedBox(
      height: Get.height * 0.18,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(Get.width * 0.02),
            child: Container(
              padding: EdgeInsets.all(Get.width * 0.025),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(Get.width * 0.03),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    categories[index]["imagePath"]!,
                    height: Get.height * 0.08,
                    width: Get.width * 0.18,
                  ),
                  SizedBox(height: Get.height * 0.01),
                  SizedBox(
                    width: Get.width * 0.18,
                    child: Text(
                      categories[index]["text1"]!,
                      style: TextStyle(color: Colors.black, fontSize: Get.width * 0.03),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

  // Testimonial Card Widget
  Widget testimonialCard({
    required String name,
    required String image,
    required String text,
  }) {
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
          // CircleAvatar(
          //   radius: 30,
          //   backgroundColor: image.isEmpty ? Colors.grey : null,
          //   child: image.isNotEmpty
          //       ? ClipOval(
          //     child: Image.network(
          //       image,
          //       width: 60,
          //       height: 60,
          //       fit: BoxFit.cover,
          //       loadingBuilder: (context, child, loadingProgress) {
          //         if (loadingProgress == null) return child;
          //         return const Center(
          //           child: CircularProgressIndicator(strokeWidth: 2),
          //         );
          //       },
          //       errorBuilder: (context, error, stackTrace) {
          //         debugPrint('Image load error: $error');
          //         return const Icon(Icons.error, color: Colors.red, size: 30);
          //       },
          //     ),
          //   )
          //       : const Icon(Icons.person, color: Colors.white, size: 30),
          // ),
          Image.network(
            height: 55,
            width: 55,
            '$imageBrandBaseUrl${image ?? ''}',
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.error),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2));
            },
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style:   TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(text,
            style:   TextStyle(fontSize: 12, color: Colors.black54),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}