

import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/BrandListSerice.dart';
import 'package:fonofy/models/BrandListModel/BrandListModel.dart';
import 'package:get/get.dart';




class BrandListController extends GetxController {
  var isBrandListLoading = true.obs;
  var brandList = <BrandListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBrandListData();
  }

  Future<void> getBrandListData() async {
    try {
      isBrandListLoading(true);
      final response = await BrandListService.fetchBrandList();
      brandList.assignAll(response ?? []);
      if (brandList.isEmpty) {
        Get.snackbar(
          'No Data',
          'No brands found.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (err) {
      Get.snackbar(
        'Error',
        'Failed to fetch brands: $err',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isBrandListLoading(false);
    }
  }
}
