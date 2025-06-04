import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:fonofy/models/RepairBrandListModel/RepairBrandListModel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';

import '../../pages/SelectProductRepairScreen/SelectProductRepairScreen.dart';
import '../../pages/SelectProductScreen/SelectProductScreen3.dart';

// return Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     // Title
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Text("Top Brands",
//         style: TextStyle(
//             fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
//       ),
//     ),
//     const SizedBox(height: 8),
//
//     // Grid View for Brands
//     GridView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(), // Disable grid scrolling
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3, // 3 columns per row
//         crossAxisSpacing: 8.0,
//         mainAxisSpacing: 8.0,
//         childAspectRatio: 1.2, // Adjust this based on your design
//       ),
//       itemCount: brands.length,
//       itemBuilder: (context, index) {
//         return Column(
//           children: [
//             // Brand Image
//             Container(
//               // height: Get.height * 0.10,
//               height: 70,
//               width: Get.width * 0.30,
//               decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 border: Border.all(color: Colors.grey, width: 1),
//               ),
//               child: ClipRect(
//                 child: Image.asset(
//                   brands[index]['imagePath']!,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 5),
//             Text(
//               brands[index]['brandName']!,
//               style:  TextStyle(
//                   fontSize: 12, fontWeight: FontWeight.w500),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         );
//       },
//     ),
//   ],
// );

Widget topBrands(List<RepairBrandListModel>? brandRepairListTopData) {
  return ListView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Top Brands",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brandRepairListTopData?.length ?? 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final brandTopRepairDetails = brandRepairListTopData?[index];
            return GestureDetector(
              onTap: () {
                if (brandTopRepairDetails != null) {
                  Get.to(() => SelectProductRepairScreen(brandName: brandTopRepairDetails.brandName ?? ''));
                }
              },
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: ClipRect(
                      child: Image.network(
                        '$imageAllBaseUrl${brandTopRepairDetails?.brandImage ?? ''}',
                        height: 55,
                        width: 55,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image,color: Colors.blueGrey,),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator(strokeWidth: 1,color: Colors.blue,));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    brandTopRepairDetails?.brandName ?? '',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
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