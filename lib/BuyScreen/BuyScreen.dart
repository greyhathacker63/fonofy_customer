import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fonofy/CartScreen.dart';
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

            SizedBox(height: Get.height * 0.03), 
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
                {"ramSize": "8GB RAM", "price": "₹10,000"},
              ],
              selectedIndex: -1, 
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
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04), // Responsive padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hot Deal",
                style: TextStyle(
                  fontSize: Get.width * 0.045, // Responsive font size
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

        SizedBox(
          height: Get.height * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 120,
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
                            const TextStyle(color: Colors.black, fontSize: 12),
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
                          Get.to(() => CartScreen());
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
                mainAxisSize: MainAxisSize.min,
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
                    width: Get.width * 0.18, 
                    child: Text(
                      categories[index]["text1"]!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Get.width * 0.03, 
                      ),
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
          height: 110, 
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
                        Get.to(() => SelectProductScreen3()); 
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
                    SizedBox(
                      width: Get.width * 0.22,
                      child: Text(
                        brands[index]['brandName']!,
                        style: TextStyle(
                          fontSize: Get.width * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                      width: 120, 
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
          height: Get.height * 0.25, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 120, 
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

  Widget shopByRAM({
    required List<Map<String, String>> ramOptions,
    required int selectedIndex,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
            height: 120, // Adjust height as needed
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ramOptions.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> option = entry.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        // Handle selection logic
                      },
                      child: Container(
                        width: 140, // Fixed width for each item
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: index == selectedIndex
                                ? Colors.blueAccent
                                : Colors.grey.shade400,
                            width: 2,
                          ),
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.grey.shade300],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              option['ramSize']!,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            Text(
                              "RAM",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade700,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                option['price']!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget byGrade({required List<Map<String, String>> grades}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
      ),
    );
  }

  Widget networkType({required List<Map<String, String>> networks}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, 
                children: networks.map((network) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        network['imagePath']!,
                        width: Get.width * 0.40,
                        height: Get.height * 0.40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shopByPrice({required List<String> prices}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
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

  Widget shopByOS({required List<Map<String, String>> osList}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
            width: Get.width,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, 
              children: osList.map((item) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Image.asset(
                      item['imagePath']!,
                      width: Get.width * 0.45,
                      height: Get.height * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
