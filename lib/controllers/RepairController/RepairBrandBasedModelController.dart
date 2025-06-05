import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api_Service/SellService/BrandBasedModelService.dart';
import '../../models/BrandBasedModel/BrandBasedModel.dart';


class RepairBrandBasedModelController extends GetxController {
  var isRepairBrandModelLoading = true.obs;
  List<BrandBasedModel> _brandModelList = [];

  List<BrandBasedModel> get brandList => _brandModelList;

  Future<void> getRepairBrandModelsData(String brandName) async {
    isRepairBrandModelLoading.value = true;
    try {
      _brandModelList = await RepairBrandBasedModelService.fetchModelsByBrand(brandName);
    } catch (err) {
      Get.snackbar("Error", "Failed to load models: $err", backgroundColor: Colors.redAccent);
    } finally {
      isRepairBrandModelLoading.value = false;

    }
  }
}
