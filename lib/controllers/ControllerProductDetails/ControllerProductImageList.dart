// // import 'package:flutter/cupertino.dart';
// // import 'package:get/get.dart';
// //
// // import '../../Api_Service/ProductDetailsService/ProductImageListService.dart';
// // import '../../model/ProductDetailsModel/ProductImageListModel.dart';
// //
// // class ControllerProductImageList extends GetxController {
// //
// //   RxList<ProductImageListModel> productImages = <ProductImageListModel>[].obs;
// //
// //   RxInt selectedImageIndex = 0.obs;
// //   RxBool isLoading = false.obs;
// //
// //   Future<void> getProductListData({required String url, required String refNo}) async {
// //     isLoading.value = true;
// //     try {
// //       final response = await ProductImageListService.fetchProductImagesList(
// //         url: url,
// //         refNo: refNo,
// //       );
// //       if (response.isNotEmpty) {
// //         productImages.assignAll(response);
// //       } else {
// //         productImages.clear();
// //       }
// //     } catch (e) {
// //       debug// print("❌ Error fetching product images: $e");
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Api_Service/ProductDetailsService/ProductImageListService.dart';
// import '../../model/ProductDetailsModel/ProductImageListModel.dart';
//
// class ControllerProductImageList extends GetxController {
//   RxList<ProductImageListModel> productImages = <ProductImageListModel>[].obs;
//   RxInt selectedImageIndex = 0.obs;
//   RxBool isLoading = false.obs;
//
//   Future<void> getProductImageListData({required String url, required String refNo}) async {
//     isLoading.value = true;
//     try {
//       final response = await ProductImageListService.fetchProductImagesList(
//         url: url,
//         refNo: refNo,
//       );
//       if (response.isNotEmpty) {
//         productImages.assignAll(response);
//       } else {
//         productImages.clear();
//         // print("⚠️ No product images found");
//       }
//     } catch (e) {
//       debug// print("❌ Error fetching product images: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
