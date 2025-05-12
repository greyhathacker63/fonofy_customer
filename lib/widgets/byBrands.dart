import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/model/table_banner_model/SelectProduct/SelectProductScreen3.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';

import '../model/ByScreenTableModel/ByScreenTableModel.dart';

Widget byBrands({List<Table1Element>? buyTableBrands}) {
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
      const SizedBox(height: 8),
      // Scrollable Brand List
      SizedBox(
        height: Get.height * 0.15,
        width: Get.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: buyTableBrands?.length ?? 0,
          itemBuilder: (context, index) {
            final buyBrandsDetails = buyTableBrands?[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  // Clickable Brand Image
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SelectProductScreen3());
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double radius = constraints.maxWidth * 0.12;
      
                        return Container(
                          height: Get.height * 0.10,
                          width: Get.width * 0.35,
                          // decoration: BoxDecoration(
                          //   color: Colors.white,
                          //   border: Border.all(color: Colors.grey, width: 1),
                          //   borderRadius: BorderRadius.circular(radius),
                          // ),
      
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
      
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              '${imageAllBaseUrl}${buyBrandsDetails?.brandImage ?? ""}',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      
                  const SizedBox(height: 10),
      
                  // Brand Name
                  Text(
                    buyBrandsDetails?.brandName.toString() ?? "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
