
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/RepairColorModelService/RepairBrandListService.dart';
import 'package:fonofy/models/RepairBrandListModel/RepairBrandListModel.dart';
import 'package:get/get.dart';



class RepairBrandListController extends GetxController {
  var isRepairListLoading = true.obs;
  var brandListRepair = <RepairBrandListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      getRepairBrandListData();
      refreshRepairBrandList();
    });
  }

  Future<void> getRepairBrandListData() async {
    try {
       Future.microtask(() => isRepairListLoading.value = true);
      final response = await RepairBrandListService.fetchRepairBrandList();
      if (response != null && response.isNotEmpty) {
        brandListRepair.assignAll(response);
      } else {
        brandListRepair.clear();
        Future.microtask(() {
          Get.snackbar(
            'Error',
            'No brands available',
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.TOP,
          );
        });
      }
    } catch (err) {
      brandListRepair.clear();
      Future.microtask(() {
        Get.snackbar(
          'Error',
          'Failed to load brands: $err',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.TOP,
        );
      });
    } finally {
      Future.microtask(() => isRepairListLoading.value = false);
    }
  }
  void refreshRepairBrandList() {
    brandListRepair.clear();
    getRepairBrandListData();
  }
}