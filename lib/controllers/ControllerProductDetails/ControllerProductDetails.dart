
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ProductDetailsService/ProductDetailsService.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductImageListModel.dart';
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
}
