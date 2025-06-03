import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/SellBrandBasedModelService.dart';
import 'package:fonofy/model/SellModel/BrandBasedModel.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SellBrandBasedModelController extends GetxController {
  var isSellBrandModelLoading = true.obs;
  var brandResponse = BrandBasedResponse(models: [], series: []).obs;

  List<BrandBasedModel> get models => brandResponse.value.models;
  List<BrandSeries> get series => brandResponse.value.series;

  Future<void> getSellBrandModelsData(String brandName) async {
    isSellBrandModelLoading.value = true;
    try {
      brandResponse.value = await SellBrandBasedModelService.fetchSellModelsByBrand(brandName);
    } catch (err) {
      print('Brand Model Error: $err');
      Get.snackbar("Error", "Failed to load models: $err", backgroundColor: Colors.redAccent);
    } finally {
      isSellBrandModelLoading.value = false;
    }
  }
}
