import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/ProductScreens/ProductScreen.dart';
import 'package:fonofy/ViewScreen/BuyRefurbishedProductScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../model/ByScreenTableModel/ByScreenTableModel.dart';
import '../utils/Colors.dart';

Widget hotdeal({List<Table2Element>? hotTableDeal}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
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
                Get.to(() => ProductScreen(productName: 'viewall'));
                print("View All Pressed");
              },
              child: const Text("View All"),
            )
          ],
        ),
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: Get.height * 0.27,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: hotTableDeal?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final hotDealDetails = hotTableDeal?[index];
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
                    Image.network(
                      height: 55,
                      width: 55,
                      '${imageAllBaseUrl}${hotDealDetails?.image ?? ""}',
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2));
                      },
                    ),
                    Text(
                      hotDealDetails?.productAndModelName.toString() ?? "",
                      style: const TextStyle(color: Colors.black, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),

                    Text(
                      '₹ ${hotDealDetails?.amount.toString() ?? ''}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),

                    // Button
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => BuyRefurbishedProductScreen(
                                url: hotDealDetails?.modelUrl.toString() ?? '',
                                refNo: hotDealDetails?.ucode.toString() ?? '',
                              ));
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
