import 'package:flutter/material.dart';
 import 'package:fonofy/model/table_banner_model/SelectProduct/SelectProductScreen3.dart';
  import 'package:get/get.dart';

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: AllBrandsScreen(),
//     );
//   }
// }

import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';

import '../controllers/SellControllers/BrandListControllers.dart';
import '../utils/Colors.dart';
// class AllBrandsScreen extends StatelessWidget {
//
//   AllBrandsScreen({super.key,});
//
//   final BrandListController brandController = Get.put(BrandListController());
//
//   @override
//   Widget build(BuildContext context) {
//     brandController.getBrandListData();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("All Brands"),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//
//             },
//           ),
//         ],
//       ),
//       body: Obx(() => Padding(
//         padding:   EdgeInsets.all(8.0),
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//             side: BorderSide(color: Colors.grey.shade300, width: 1),
//           ),
//           elevation: 3,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: brandController.isBrandListLoading.value
//                 ? const Center(
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 color: Colors.blue,
//               ),
//             )
//                 : brandController.brandList.isEmpty
//                 ? const Center(child: Text("No brands available"))
//                 : GridView.builder(
//               physics: const AlwaysScrollableScrollPhysics(),
//               itemCount: brandController.brandList.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//                 childAspectRatio: 0.8,
//               ),
//               itemBuilder: (context, index) {
//                 final brand = brandController.brandList[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Get.to(() => SelectProductScreen3(brandName: brand.brandName ?? ''));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300, width: 1),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         brand.brandImage != null && brand.brandImage!.isNotEmpty
//                             ? Image.network(
//                           "$imageAllBaseUrl${brand.brandImage}",
//                           height: 50,
//                           width: 50,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) => SizedBox(
//                             height: 50,
//                             width: 50,
//                             child: Icon(
//                               Icons.error,
//                               color: Colors.black,
//                               size: 40,
//                             ),
//                           ),
//                         )
//                             : SizedBox(
//                           height: 50,
//                           width: 50,
//                           child: Icon(
//                             Icons.error,
//                             color: Colors.black,
//                             size: 40,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           brand.brandName ?? 'Unknown Brand',
//                           style: const TextStyle(fontSize: 12),
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

 // Adjust path

class AllBrandsScreen extends StatelessWidget {

  final BrandListController brandController = Get.put(BrandListController());

  AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Brands"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
            child: brandController.isBrandListLoading.value
                ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue,
              ),
            )
                : brandController.brandList.isEmpty
                ? const Center(child: Text("No brands available"))
                : GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: brandController.brandList.length,
              gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final brand = brandController.brandList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => SelectProductScreen3(brandName: brand.brandName ?? ''));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        brand.brandImage != null && brand.brandImage!.isNotEmpty
                            ? Image.network(
                          "$imageAllBaseUrl${brand.brandImage}".replaceAll('//', '/'),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.image,
                              color: ColorConstants.appBlueColor3,
                              size: 40,
                            ),
                          ),
                        )
                            : SizedBox(
                          height: 50,
                          width: 50,
                          child: Icon(
                            Icons.image,
                            color: ColorConstants.appBlueColor3,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          brand.brandName ?? 'Unknown Brand',
                          style: const TextStyle(fontSize: 12),
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