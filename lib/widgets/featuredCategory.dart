import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../ProductScreens/ProductScreen.dart';
import '../model/ByScreenTableModel/ByScreenTableModel.dart';

Widget featuredCategory({
  List<Map<String, String>>? categories,
  List<Table1Element>? featuredCategoryTable,
}) {
  List<dynamic> combinedItems = [
    ...?categories,
    ...(featuredCategoryTable ?? []),
  ];

  return SizedBox(
    height: Get.height * 0.18,
    width: Get.width,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: combinedItems.length,
      itemBuilder: (context, index) {
        final item = combinedItems[index];
        final isStatic = item is Map<String, String>;

        return Padding(
          padding: EdgeInsets.all(Get.width * 0.02),
          child: GestureDetector(
            onTap: () {
              if (isStatic) {
                String category = item["text1"] ?? "";
                print("Clicked on static category: $category");

                // New mapping logic
                if (category == "Deal of the day") {
                  Get.to(() => ProductScreen(
                      name: "", productPage: "Deals_of_the_day"));
                } else if (category == "Refurbished Mobiles") {
                  Get.to(() => ProductScreen(
                      name: "", productPage: "refurbished"));
                } else {
                  Get.to(() =>
                      ProductScreen(name: category, productPage: ""));
                      
                }
              } else {
                print("Clicked on dynamic category: ${item.brandName}");
                Get.to(() => ProductScreen(
                    name: item.brandName ?? "", productPage: ""));
              }
            },
            child: Container(
              padding: EdgeInsets.all(Get.width * 0.025),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(Get.width * 0.03),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isStatic
                      ? Image.asset(
                          item["imagePath"]!,
                          height: Get.height * 0.07,
                          width: Get.width * 0.18,
                          fit: BoxFit.contain,
                        )
                      : ClipOval(
                          child: Image.network(
                            '${imageAllBaseUrl}${item.offerImage ?? ""}',
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              );
                            },
                          ),
                        ),
                  SizedBox(height: Get.height * 0.01),
                  SizedBox(
                    width: Get.width * 0.18,
                    child: Text(
                      isStatic ? item["text1"]! : (item.brandName ?? ''),
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
          ),
        );
      },
    ),
  );
}
