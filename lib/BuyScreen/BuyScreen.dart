import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fonofy/SelectProductScreen.dart';
import 'package:fonofy/SelectProductScreen3';
import 'package:fonofy/widgets/Colors.dart';
import 'package:get/get.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  final List<String> bannerImages = [
    "assets/images/banner.png",
    "assets/images/banner.png",
    "assets/images/banner.png",
    "assets/images/banner.png"
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            // **Carousel Slider Section**
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: Get.height * 0.15, 
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      autoPlay: false, 
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: bannerImages.map((imagePath) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
                          width: Get.width * 1.30,
                        ),
                      );
                    }).toList(),
                  ),

                  // **Carousel Dots Indicator**
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: bannerImages.asMap().entries.map((entry) {
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

            //     // Featured Categories Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Featured Categories",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  featuredCategory(imagePath: "assets/images/Deal.png")
                ],
              ),
            ),

            // Banner Image
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset("assets/images/sellBanner.png",
                  height: Get.height * 0.18, fit: BoxFit.contain),
            ),

            //Hot Deals
            hotdeal(
                imagePath: "assets/images/phone.png",
                text1: "Apple IPhone 36 GB"),

            //By Brands
            byBrands(brands: [
              {"imagePath": "assets/images/oppo.png", "brandName": 'Oppo'},
              {
                "imagePath": "assets/images/applephone.png",
                "brandName": 'Apple'
              },
              {"imagePath": "assets/images/oppo.png", "brandName": 'Oppo'},
              {
                "imagePath": "assets/images/applephone.png",
                "brandName": 'Apple'
              },
              {
                "imagePath": "assets/images/applephone.png",
                "brandName": 'Apple'
              },
              {
                "imagePath": "assets/images/applephone.png",
                "brandName": 'Apple'
              },
              {
                "imagePath": "assets/images/applephone.png",
                "brandName": 'Apple'
              }
            ]),
            //Deal of the day
            dealOfTheDay(
                imagePath: "assets/images/phone.png",
                text1: "Latest Devices Available"),
            //Banner
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                "assets/images/banner2.png",
                height: Get.height * 0.16,
                fit: BoxFit.cover,
                width: Get.width * 1.0,
              ),
            ),

            //Amazing Deal
            AmazingDeal(
                imagePath: "assets/images/phone.png", text1: "Mobile Phone"),

            //Banner
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset("assets/images/banner3.png",
                  height: Get.height * 0.15,
                  fit: BoxFit.cover,
                  width: Get.width * 1.0),
            ),
            shopByRAM(
              ramOptions: [
                {"ramSize": "4GB RAM", "price": "₹5,000"},
                {"ramSize": "6GB RAM", "price": "₹6,000"},
                {"ramSize": "6GB RAM", "price": "₹6,000"},
                {"ramSize": "6GB RAM", "price": "₹6,000"},
              ],
            ),
            byGrade(
              grades: [
                {"grade": "F1+ = Superb", "color": "blue"},
                {"grade": "F1 = Excellent", "color": "green"},
                {"grade": "F2 = Fair", "color": "purple"},
              ],
            ),
            networkType(
              networks: [
                {"imagePath": "assets/images/4g.png"},
                {"imagePath": "assets/images/5g.png"},
              ],
            ),
            shopByPrice(
              prices: ["Less Than ₹4000", "₹4000 To ₹5000", "₹5000 To ₹7000"],
            ),
            shopByOS(
              osList: [
                {"imagePath": "assets/images/androidBanner.png"},
                {"imagePath": "assets/images/iosBanner.png"},
              ],
            ),
          ],
        )));
  }

  Widget productCard({required String imagePath, required String label}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
          ),
          child: Image.asset(imagePath, height: 80),
        ),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

 Widget hotdeal({String? imagePath, String? text1}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Heading with "View All" on Right
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hot Deal",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                print("View All Pressed");
              },
              child: const Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Blue Color
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),

      // Scrollable List of Deals
      SizedBox(
        height: Get.height * 0.25, // Increased height to avoid overflow
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 120, // Fixed width to keep all items aligned
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Image
                    Image.asset(
                      imagePath!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),

                    // Text
                    Text(
                      text1!,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "Free 6 months warranty",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                      ),
                    ),

                    // Button
                    ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.appBlueColor3,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}


  featuredCategory({String? imagePath, String? text1}) {
    return SizedBox(
      height: Get.height * 0.15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Image.asset(
                      imagePath!,
                      height: 50,
                      width: 70,
                    ),
                    Text(
                      text1 ?? "Deal of the day",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget byBrands({required List<Map<String, String>> brands}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "By Brands",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const SizedBox(height: 12),
// Scrollable Brand List
        SizedBox(
          height: 110, // Increased height to fit text
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    // Clickable Brand Image
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SelectProductScreen3()); // Navigate on tap
                      },
                      child: Container(
                        height: Get.height * 0.10,
                        width: Get.width * 0.35,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: ClipRect(
                          child: Image.asset(
                            brands[index]['imagePath']!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Brand Name
                    Text(
                      brands[index]['brandName']!,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
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

  Widget dealOfTheDay({String? imagePath, String? text1}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: ColorConstants.appBlueColor4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Deal of the day",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 8),

            // Scrollable List of Deals
            SizedBox(
              height: Get.height * 0.25, // Increased height to avoid overflow
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120, // Fixed width to keep all items aligned
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Image
                          Image.asset(
                            imagePath!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),

                          // Text
                          Text(
                            text1!,
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "Best Deals",
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),

                          // Button
                          ElevatedButton(
                            onPressed: () {
                              print("Add Pressed");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.appBlueColor3,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Add",
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget AmazingDeal({String? imagePath, String? text1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Amazing Deal",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const SizedBox(height: 8),

        // Scrollable List of Deals
        SizedBox(
          height: Get.height * 0.25, // Increased height to avoid overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 120, // Fixed width to keep all items aligned
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Image
                      Image.asset(
                        imagePath!,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),

                      // Text
                      Text(
                        text1!,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        "Best Deals",
                        style: TextStyle(color: Colors.blue, fontSize: 10),
                      ),

                      // Button
                      ElevatedButton(
                        onPressed: () {
                          print("Add Pressed");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.appBlueColor3,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget shopByRAM({required List<Map<String, String>> ramOptions}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Shop By RAM",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ramOptions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 120,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorConstants.appBlueColor5,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      // 🔹 Adds border around each item
                      color: Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ramOptions[index]['ramSize']!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ramOptions[index]['price']!,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget byGrade({required List<Map<String, String>> grades}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "By Grade",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: grades.map((grade) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: grade['color'] == "blue"
                      ? ColorConstants.lightColor
                      : grade['color'] == "green"
                          ? ColorConstants.greenColor
                          : Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  grade['grade']!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget networkType({required List<Map<String, String>> networks}) {
    return Container(
      color: ColorConstants.appGreyColor2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Network Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: networks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      networks[index]['imagePath']!,
                      width: 120,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget shopByPrice({required List<String> prices}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Shop By Price",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: prices.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      prices[index],
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget shopByOS({required List<Map<String, String>> osList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Shop By OS",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: osList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Image.asset(
                        osList[index]['imagePath']!,
                        width: 120,
                        height: Get.height * 0.15,
                        fit: BoxFit.cover,
                      ),
                    )),
              );
            },
          ),
        ),
      ],
    );
  }
}
