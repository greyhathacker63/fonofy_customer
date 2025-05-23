
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/RepairColorModelService/RepairBrandListService.dart';
import 'package:fonofy/model/RepairModel/RepairBrandListModel.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// class RepairBrandListController extends GetxController {
//   var isRepairListLoading = true.obs;
//   List<RepairBrandListModel> _brandList = [];
//
//   List<RepairBrandListModel> get brandList => _brandList;
//
//   Future<void> getRepairBrandListData() async {
//     isRepairListLoading.value = true;
//     try {
//       _brandList = await RepairBrandListService.fetchRepairBrandList();
//     } catch (err) {
//       debugPrint('Brand List Error: $err');
//     } finally {
//       isRepairListLoading.value = false;
//       update(); // Notify UI
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RepairBrandListController extends GetxController {
  var isRepairListLoading = true.obs;
  var brandListRepair = <RepairBrandListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      print('Initializing RepairBrandListController');
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
      debugPrint('Repair Brand List Error: $err');
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