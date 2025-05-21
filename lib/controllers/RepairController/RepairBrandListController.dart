
import 'package:flutter/cupertino.dart';
import 'package:fonofy/Api_Service/SellService/RepairColorModelService/RepairBrandListService.dart';
import 'package:fonofy/model/RepairModel/RepairBrandListModel.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RepairBrandListController extends GetxController {
  var isRepairListLoading = true.obs;
  List<RepairBrandListModel> _brandList = [];

  List<RepairBrandListModel> get brandList => _brandList;

  Future<void> getRepairBrandListData() async {
    isRepairListLoading.value = true;
    try {
      _brandList = await RepairBrandListService.fetchRepairBrandList();
    } catch (err) {
      debugPrint('Brand List Error: $err');
    } finally {
      isRepairListLoading.value = false;
      update(); // Notify UI
    }
  }
}