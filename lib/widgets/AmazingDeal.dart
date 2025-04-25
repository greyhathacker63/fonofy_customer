import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../ViewScreen/BuyRefurbishedProductScreen.dart';
import '../model/ByScreenTableModel/ByScreenTableModel.dart';

Widget AmazingDeal({List<Table2Element>? AmazingDealTable}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Heading
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text("Amazing Deal",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      const SizedBox(height: 8),

      SizedBox(
        height: Get.height * 0.25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: AmazingDealTable?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {

            final amazingDealTableDetails = AmazingDealTable?[index];

            return GestureDetector(
                onTap: () {
                  Get.to(()=> BuyRefurbishedProductScreen(url: amazingDealTableDetails?.modelUrl.toString()?? '',
                      refNo: amazingDealTableDetails?.ucode.toString() ?? ''
                  ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      Container(
                        width: 140,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Image
                            Image.network(
                              width: 50,
                              height: 50,
                              '${imageAllBaseUrl}${amazingDealTableDetails?.image ?? ""}',
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
                              amazingDealTableDetails?.productAndModelName.toString() ?? '',
                              style: const TextStyle(color: Colors.blue, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '₹ ${amazingDealTableDetails?.amount.toString() ?? ''}',
                              style: const TextStyle(color: Colors.blue, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            Center(
                              child: Text(
                                '₹ ${amazingDealTableDetails?.newModelAmt.toString() ?? ''}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Discount Badge (Top-Right)
                      Positioned(
                        top: -5.0,
                        right: -5.0,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                          child: Text(
                            '${amazingDealTableDetails?.discountPercentage.toString() ?? ''}% Off',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center, // Optional (for multiline)
                          ),
                        ),
                      ),

                    ],
                  ),
                )
            );
          },
        ),
      ),
    ],
  );
}
