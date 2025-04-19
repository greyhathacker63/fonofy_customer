import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/ViewScreen/BuyRefurbishedProductScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../model/ByScreenTableModel/ByScreenTableModel.dart';
import '../utils/Colors.dart';

Widget dealOfTheDay({List<Table2Element>? DealOfTheDayTable}) {
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
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Scrollable List of Deals
          SizedBox(
            height: Get.height * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: DealOfTheDayTable?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final dealOfTheDayTableDetails = DealOfTheDayTable?[index];
                return GestureDetector(
                  onTap: () {
                   Get.to(()=> BuyRefurbishedProductScreen(url: dealOfTheDayTableDetails?.modelUrl.toString()?? '',
                       refNo: dealOfTheDayTableDetails?.ucode.toString() ?? ''
                   ),
                   );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 150,
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
                              Image.network(
                                '${imageAllBaseUrl}${dealOfTheDayTableDetails?.image ?? ''}',
                                height: 55,
                                width: 55,
                                fit: BoxFit.cover,
                              ),

                              // Product Name
                              Text(
                                dealOfTheDayTableDetails?.productAndModelName ?? '',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              // Current Price
                              Text(
                                '₹ ${dealOfTheDayTableDetails?.amount ?? ''}',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              // Old Price (Strikethrough)
                              Text(
                                '₹ ${dealOfTheDayTableDetails?.newModelAmt ?? ''}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        // Discount Badge
                        Positioned(
                          top: 0.0,
                          right: 1.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              '${dealOfTheDayTableDetails?.discountPercentage ?? ''}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
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
      ),
    ),
  );
}
