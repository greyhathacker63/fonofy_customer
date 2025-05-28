import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/model/ByScreenTableModel/ByScreenTableModel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/Colors.dart';

// Widget networkType({List<Table8>?  networksData}) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Container(
//       color: ColorConstants.appGreyColor2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text("Network Type",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(height: 8),
//           SizedBox(
//             height: 100,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: networksData.map((network) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.asset(
//                       network['imagePath']!,
//                       width: Get.width * 0.40,
//                       height: Get.height * 0.40,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

Widget networkType({List<Table8>? networksData}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      color: ColorConstants.appGreyColor2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text("Network Type",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: Get.height * 0.12,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: networksData?.length ?? 0,
              itemBuilder: (context, index) {
                final networkDetails = networksData![index];
                final imageUrl = networkDetails.image;
                final hasImage = imageUrl != null && imageUrl.isNotEmpty;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: hasImage
                            ? Image.network(
                          "$imageAllBaseUrl$imageUrl",
                          width: Get.width * 0.40,
                          height: Get.height * 0.10,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _placeholderIcon(),) : _placeholderIcon(),
                      ),
                    ],
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

// Placeholder widget
Widget _placeholderIcon() {
  return Container(
    width: Get.width * 0.40,
    height: Get.height * 0.10,
    color: Colors.grey.shade300,
    child: Icon(Icons.image,
      size: 30,
      color: ColorConstants.appBlueColor3,
    ),
  );
}


