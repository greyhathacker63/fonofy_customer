
// import 'package:flutter/material.dart';
// import 'package:fonofy/Api_Service/ProductDetailsService/ProductDetailsService.dart';
// import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
// import 'package:fonofy/model/ProductDetailsModel/ProductImageListModel.dart';
// import 'package:get/get.dart';

// class ControllerProductDetails extends GetxController {
//
//   var productDetails = Rxn<ProductDetailsModel>();
//
//   Future<void> getProductDetailsData({required String url, required String refNo}) async {
//     try {
//       var response = await ProductDetailsService().fetchProductDetailsData(
//         Url: url,
//         Refno: refNo,
//       );
//       if (response.isNotEmpty) {
//         productDetails.value = response.first;
//       }
//     } catch (e) {
//       print("Error fetching product details: $e");
//     }
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ProductDetailsService/ProductDetailsService.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ProductDetailsService/ProductDetailsService.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ProductDetailsService/ProductDetailsService.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ProductDetailsService/ProductDetailsService.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:get/get.dart';

class ControllerProductDetails extends GetxController {
  var productDetails = Rxn<ProductDetailsModel>();

  Future<void> getProductDetailsData({required String url, required String refNo}) async {
    try {
      var response = await ProductDetailsService().fetchProductDetailsData(
        Url: url,
        Refno: refNo,
      );
      if (response.isNotEmpty) {
        productDetails.value = response.first;
      }
    } catch (e) {
      print("Error fetching product details: $e");
    }
  }

  void updateProductVariant({
    required String ramName,
    required String romName,
    required String colorName,
    required double? sellingPrice,
    required String condition,
  }) {
    if (productDetails.value != null) {
      productDetails.value = ProductDetailsModel(
        modelNo: productDetails.value!.modelNo,
        modelUrl: productDetails.value!.modelUrl,
        ucode: productDetails.value!.ucode,
        productAndModelName: productDetails.value!.productAndModelName,
        ramId: productDetails.value!.ramId,
        ramName: ramName,
        romId: productDetails.value!.romId,
        romName: romName,
        colorId: productDetails.value!.colorId,
        colorName: colorName,
        sellingPrice: sellingPrice,
        sellingPriceF1: productDetails.value!.sellingPriceF1,
        sellingPricePlus: productDetails.value!.sellingPricePlus,
        newModelAmt: productDetails.value!.newModelAmt,
        stockQuantity: productDetails.value!.stockQuantity,
        display: productDetails.value!.display,
        // Include other fields as needed
      );
    }
  }
}