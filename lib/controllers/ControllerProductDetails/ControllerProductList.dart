import 'package:flutter/cupertino.dart';
import 'package:fonofy/Api_Service/ProductDetailsService/ProductDetailsListService.dart';
import 'package:fonofy/models/ProductDetailsListModel/ProductDetailsListModel.dart';
import 'package:get/get.dart';

class ControllerProductDetailsList extends GetxController {
  // Use RxList instead of a single Rxn item
  RxList<ProductDetailsListModel> productDetailsList = <ProductDetailsListModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> getProductListData() async {
    isLoading.value = true;
    try {
      // Create an instance of the service
      final response = await ProductDetailsListService().fetchProductDetailsListData();

      if (response.isNotEmpty) {
        productDetailsList.assignAll(response);
      } else {
        productDetailsList.clear(); // No data
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
