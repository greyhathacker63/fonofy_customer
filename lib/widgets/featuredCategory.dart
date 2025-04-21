import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/ViewScreen/BuyRefurbishedProductScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../ProductScreens/ProductScreen.dart';
import '../model/ByScreenTableModel/ByScreenTableModel.dart';

Widget featuredCategory({
 

 List<Map<String, String>>? categories,
   List<Table1Element>? featuredCategoryTable,
}) {
  final List<dynamic> combinedItems = [
    // ...categories,
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
              Get.to(()=> ProductScreen(productName:combinedItems[index].brandName.toString() ,));
              // Get.to(() => BuyRefurbishedProductScreen(url: '', refNo: '',), arguments: {
              //   "category": isStatic ? item["text1"] : item.brandName,
              // });
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
                      loadingBuilder:
                          (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                              strokeWidth: 2),
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