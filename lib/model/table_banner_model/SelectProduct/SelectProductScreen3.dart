import 'package:flutter/material.dart';
import 'package:fonofy/SellScreen/selectColorsProductScreen.dart';
 import 'package:fonofy/model/table_banner_model/SelectProduct/SelectProductScreen.dart';
import 'package:get/get.dart';

 import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';

import '../../../controllers/RepairController/BrandBasedModelController.dart';

// class SelectProductScreen3 extends StatelessWidget {
//   final String brandName;
//
//
//   SelectProductScreen3({super.key, required this.brandName});
//
//   final BrandBasedModelController modelController = Get.put(BrandBasedModelController());
//
//   final String placeholderImage = "assets/images/phone.png";
//   @override
//   Widget build(BuildContext context) {
//     modelController.getBrandModelsData(brandName);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Select $brandName Model"),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Implement search functionality if needed
//             },
//           ),
//         ],
//       ),
//       body: Obx(() => Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//             side: BorderSide(color: Colors.grey.shade300, width: 1),
//           ),
//           elevation: 3,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: modelController.isBrandModelLoading.value
//                 ? const Center(
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 color: Colors.blue,
//               ),
//             )
//                 : modelController.brandList.isEmpty
//                 ? Center(child: Text("No models available for $brandName"))
//                 : GridView.builder(
//               itemCount: modelController.brandList.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//                 childAspectRatio: 1.0,
//               ),
//               itemBuilder: (context, index) {
//                 final model = modelController.brandList[index];
//                 return GestureDetector(
//                   onTap: () {
//                     // Get.to(() => SelectProductScreen());
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300, width: 1),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//
//                       children: [
//                         model.image != null && model.image!.isNotEmpty
//                             ? Image.network(
//                           "$imageAllBaseUrl${model.image}",
//                           height: 50,
//                           width: 50,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) =>
//                               Image.asset(
//                                 placeholderImage,
//                                 height: 50,
//                                 width: 50,
//                                 fit: BoxFit.cover,
//                               ),
//                         )
//                             : Image.asset(
//                           placeholderImage,
//                           height: 50,
//                           width: 50,
//                           fit: BoxFit.cover,
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           model.productAndModelName ?? 'Unknown Model',
//                           style: const TextStyle(fontSize: 14),
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }


// class SelectProductScreen3 extends StatelessWidget {
//   final String brandName;
//   final String placeholderImage = "assets/images/phone.png";
//
//   SelectProductScreen3({super.key, required this.brandName});
//
//   final BrandBasedModelController brandBasedRepairController = Get.put(BrandBasedModelController());
//
//   @override
//   Widget build(BuildContext context) {
//     brandBasedRepairController.getBrandModelsData(brandName);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Select $brandName Model"),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Implement search functionality if needed
//             },
//           ),
//         ],
//       ),
//       body: Obx(() => Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//             side: BorderSide(color: Colors.grey.shade300, width: 1),
//           ),
//           elevation: 3,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: brandBasedRepairController.isRepairBrandModelLoading.value
//                 ? const Center(
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 color: Colors.blue,
//               ),
//             )
//                 : brandBasedRepairController.brandList.isEmpty
//                 ? Center(child: Text("No models available for $brandName"))
//                 : GridView.builder(
//               itemCount: brandBasedRepairController.brandList.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//                 childAspectRatio: 1.0,
//               ),
//               itemBuilder: (context, index) {
//                 final brandBasedModelDetails = brandBasedRepairController.brandList[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Get.to(() => SelectProductScreen());
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300, width: 1),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         brandBasedModelDetails.image != null && brandBasedModelDetails.image!.isNotEmpty
//                             ? Image.network(
//                           "$imageAllBaseUrl${brandBasedModelDetails.image}",
//                           height: 50,
//                           width: 50,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) =>
//                               Image.asset(
//                                 placeholderImage,
//                                 height: 50,
//                                 width: 50,
//                                 fit: BoxFit.cover,
//                               ),
//                         )
//                             : Image.asset(
//                           placeholderImage,
//                           height: 50,
//                           width: 50,
//                           fit: BoxFit.cover,
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           brandBasedModelDetails.productAndModelName ?? 'Unknown Model',
//                           style: const TextStyle(fontSize: 14),
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }


class SelectProductScreen3 extends StatelessWidget {
  final String brandName;
  final String placeholderImage = "assets/images/phone.png";

  SelectProductScreen3({super.key, required this.brandName});

  final RepairBrandBasedModelController brandBasedRepairController = Get.put(RepairBrandBasedModelController());

  @override
  Widget build(BuildContext context) {
    brandBasedRepairController.getBrandModelsData(brandName);

    return Scaffold(
      appBar: AppBar(
        title: Text("Select $brandName Model"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality if needed
            },
          ),
        ],
      ),
      body: Obx(() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: brandBasedRepairController.isRepairBrandModelLoading.value
                ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue,
              ),
            )
                : brandBasedRepairController.brandList.isEmpty
                ? Center(child: Text("No models available for $brandName"))
                : GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: brandBasedRepairController.brandList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8, // Adjusted to make cells taller
              ),
              itemBuilder: (context, index) {
                final brandBasedModelDetails = brandBasedRepairController.brandList[index];
                return GestureDetector(
                  onTap: () {
                    // Get.to(() => SelectProductScreen());},
                    Get.to(() => SelectColorsProductScreen(brandName: '', modelId: ''));},

                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        brandBasedModelDetails.image != null && brandBasedModelDetails.image!.isNotEmpty
                            ? Image.network("$imageAllBaseUrl${brandBasedModelDetails.image}",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.error,
                              color: Colors.black87,
                              size: 40,
                            ),
                          ),
                        )
                            : SizedBox(
                          height: 50,
                          width: 50,
                          child: Icon(
                            Icons.error,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 4), // Reduced spacing
                        Text(
                          brandBasedModelDetails.productAndModelName ?? 'Unknown Model',
                          style: const TextStyle(fontSize: 12), // Reduced font size
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      )),
    );
  }
}
