
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/RepairColorModelService/RepairColorsService.dart';
import 'package:fonofy/models/RepairModel/RepairModel.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class RepairColorsController extends GetxController {
  var isRepairColorsLoading = false.obs;
  var colorListRepair = <RepairModel>[].obs;

  Future<void> getRepairColorsData(String brandId, String modelId) async {
    try {
      final data = await RepairColorService.fetchRepairColorList(brandId, modelId);
      colorListRepair.assignAll(data);
    } catch (e) {
    } finally {
      isRepairColorsLoading.value = false;
    }
  }
}