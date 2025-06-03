
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/RepairColorModelService/RepairColorsService.dart';
import 'package:fonofy/model/RepairModel/RepairColorModel.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class RepairColorsController extends GetxController {
  var isRepairColorsLoading = false.obs;
  var colorListRepair = <RepairColorModel>[].obs;

  Future<void> getRepairColorsData(String brandId, String modelId) async {
    try {
      // colorListRepair.value = true as List<RepairColorModel>;
      final data = await RepairColorService.fetchRepairColorList(brandId, modelId);
      colorListRepair.assignAll(data);
    } catch (e) {
      print("Error fetching tracking data: $e");
      // Optionally show a snackbar or dialog
    } finally {
      isRepairColorsLoading.value = false;
    }
  }
}