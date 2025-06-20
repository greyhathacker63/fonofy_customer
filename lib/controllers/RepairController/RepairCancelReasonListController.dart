
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/RepairColorModelService/RepairCancelReasonListService.dart';
import 'package:fonofy/model/RepairModel/RepairCancelReasonListModel.dart';
import 'package:get/get.dart';

class ControllerRepairCancelReasonList extends GetxController{

  var isRepairCancelReasonLoading = true.obs;
  var _appRepairCancelReasonData;

  RepairCancelReasonListModel? get repairCancelReasonData => _appRepairCancelReasonData;

  Future<void> getRepairCancelReasonData() async {
    await RepairCancelReasonListService.fetchRepairCancelReasonData()
        .then((response) {
      isRepairCancelReasonLoading(true);
      _appRepairCancelReasonData = response;
      update();
    })
        .catchError((err) => debugPrint('Options Deatils Error: $err'))
        .whenComplete(() => isRepairCancelReasonLoading(false));
  }
}