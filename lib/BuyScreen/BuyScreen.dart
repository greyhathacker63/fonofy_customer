import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ControllerTable.dart';
import '../widgets/AmazingDeal.dart';
import '../widgets/byBrands.dart';
import '../widgets/byGrade.dart';
import '../widgets/dealOfTheDay.dart';
import '../widgets/featuredCategory.dart';
import '../widgets/hotdeal.dart';
import '../widgets/networkType.dart';
import '../widgets/shopByOS.dart';
import '../widgets/shopByPrice.dart';
import '../widgets/shopByRAM.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {

  final ControllerTable tableController = Get.put(ControllerTable());

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tableController.getTableOptionsData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (tableController.isTableOptionsLoading.value ||
            tableController.tableOptionsData == null) {
          return const Center(
            child: SizedBox(
              height: 35,
              width: 35,
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2,
              ),
            ),
          );
        }

        // Assume you fetch bannerImages from API here (example logic)
        final bannerImages = tableController.tableOptionsData?.table
            ?.map((item) => item.bnnerImage)
            .whereType<String>()
            .toList() ?? [];
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Carousel Slider
                if (bannerImages.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: Get.height * 0.18,
                            enlargeCenterPage: true,
                            viewportFraction: 1.0,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() => _currentIndex = index);
                            },
                          ),
                          items: bannerImages.map((imageUrl) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "http://cdn.fonofy.in//"+imageUrl,
                                fit: BoxFit.cover,
                                width: Get.width,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error, color: Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          bannerImages.asMap().entries.map((entry) {
                            return Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == entry.key
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                // Featured Categories
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
    featuredCategory(
  categories: [
    {
      "imagePath": "assets/images/Deal.png",
      "text1": "Deal of the day",
    },
    {
      "imagePath": "assets/images/refurbished.png",
      "text1": "Refurbished Mobiles",
    },
  ],
  featuredCategoryTable: tableController.tableOptionsData?.table1,
),


                    ],
                  ),
                ),

                SizedBox(height: Get.height * 0.03),
                // Static Banner
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset("assets/images/sellBanner.png",
                      height: Get.height * 0.18, fit: BoxFit.contain),
                ),

                // Dynamic Widgets
                hotdeal(hotTableDeal: tableController.tableOptionsData?.table2),

                byBrands(buyTableBrands: tableController.tableOptionsData?.table3),

                dealOfTheDay(DealOfTheDayTable: tableController.tableOptionsData?.table4),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: Get.height * 0.20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),

                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/images/banner2.png',
                          fit: BoxFit.fill,
                        )
                    ),
                  ),
                ),
                AmazingDeal(AmazingDealTable: tableController.tableOptionsData?.table7),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: Get.height * 0.20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),

                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/images/banner3.png',
                          fit: BoxFit.fill,
                        )
                    ),
                  ),
                ),
                shopByRAM(tableRamName: tableController.tableOptionsData?.table5),

                SizedBox(height: 5,),
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
                shopByPrice(shopTablePrices: tableController.tableOptionsData?.table6),
                shopByOS(
                  osList: [
                    {"imagePath": "assets/images/androidBanner.png"},
                    {"imagePath": "assets/images/iosBanner.png"},
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
