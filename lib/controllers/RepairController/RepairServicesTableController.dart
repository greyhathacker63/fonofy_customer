//
// import 'package:flutter/material.dart';
// import 'package:fonofy/Api_Service/SellService/RepairColorModelService/RepairServicesTableService.dart';
// import 'package:fonofy/model/RepairModel/RepairServicesTableModel.dart';
// import 'package:get/get.dart';
//
//
// class RepairControllerTable extends GetxController{
//
//   var isRepairTableLoading = true.obs;
//   var _appRepairTableData;
//
//   RepairServicesTableModel? get tableRepairData => _appRepairTableData;
//
//   Future<void> getTableRepairData(String bid, String pid,String cid) async {
//     await RepairTableService.fetchRepairTableData(bid, pid, cid).then((response) {
//       isRepairTableLoading(true);
//       _appRepairTableData = response;
//       update();
//     });
//   }
// }
//
//
//

import 'package:get/get.dart';
import 'package:fonofy/Api_Service/SellService/RepairColorModelService/RepairServicesTableService.dart';
import 'package:fonofy/model/RepairModel/RepairServicesTableModel.dart';


class RepairControllerTable extends GetxController {
  var isRepairTableLoading = true.obs;
  var _appRepairTableData;
  var selectedServices = <Table1>[].obs;

   var totalPrice = 0.obs;


  RepairServicesTableModel? get tableRepairData => _appRepairTableData;

  Future<void> getTableRepairData(String bid, String pid, String cid) async {
    try {
      isRepairTableLoading(true);
      final response = await RepairTableService.fetchRepairTableData(bid, pid, cid);
      _appRepairTableData = response;
    } finally {
      isRepairTableLoading(false);
      update();
    }
  }
   void addService(Table1 service) {
    if (!selectedServices.contains(service)) {
      selectedServices.add(service);

      final price = (service.price ?? 0).toInt();
      totalPrice.value += price;

      print('Added service: ${service.serviceName}, Price: $price, Total: ${totalPrice.value}');
      update();
    }
  }
  void removeService(Table1 service) {
    if (selectedServices.contains(service)) {
      selectedServices.remove(service);

      final price = (service.price ?? 0).toInt();
      totalPrice.value -= price;

      print('Removed service: ${service.serviceName}, Price: $price, Total: ${totalPrice.value}');
      update();
    }
  }

  bool isServiceSelected(Table1 service) {
    return selectedServices.contains(service);
  }
}