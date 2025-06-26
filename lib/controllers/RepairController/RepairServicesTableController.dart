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


// class RepairControllerTable extends GetxController {
//   var isRepairTableLoading = true.obs;
//   var _appRepairTableData;
//   var selectedServices = <Table1>[].obs;
//
//    var totalPrice = 0.obs;
//
//
//   // List of devices returned in response
//   var repairDevices = <RepairDeviceTable>[].obs;
//
//   // Expose RAM and ROM directly if you're sure there's only one item
//   String? ramId;
//   String? romId;
//
//   RepairServicesTableModel? get tableRepairData => _appRepairTableData;
//
//   Future<void> getTableRepairData(String bid, String pid, String cid) async {
//     try {
//       isRepairTableLoading(true);
//       final response = await RepairTableService.fetchRepairTableData(bid, pid, cid);
//       _appRepairTableData = response;
//
//       // Store the list of repair devices
//       repairDevices.value = response.table ?? [];
//
//       // If there's at least one device in the list, extract its RAM/ROM
//       if (repairDevices.isNotEmpty) {
//         ramId = repairDevices.first.ramId;
//         romId = repairDevices.first.romId;
//         print('Extracted RAM ID: $ramId, ROM ID: $romId');
//       }
//     } finally {
//       isRepairTableLoading(false);
//       update();
//     }
//   }
//
//   void addService(Table1 service) {
//     if (!selectedServices.contains(service)) {
//       selectedServices.add(service);
//       totalPrice.value += (service.price ?? 0).toInt();
//       update();
//     }
//   }
//
//   void removeService(Table1 service) {
//     if (selectedServices.contains(service)) {
//       selectedServices.remove(service);
//       totalPrice.value -= (service.price ?? 0).toInt();
//       update();
//     }
//   }
//
//   bool isServiceSelected(Table1 service) {
//     return selectedServices.contains(service);
//   }
//
//   // Helper methods to access RAM/ROM externally
//   String? getRamId() => ramId;
//   String? getRomId() => romId;
// }


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

  // List of devices returned in response
  var repairDevices = <RepairDeviceTable>[].obs;

  // Expose RAM and ROM directly if you're sure there's only one item
  String? ramId;
  String? romId;

  RepairServicesTableModel? get tableRepairData => _appRepairTableData;

  Future<void> getTableRepairData(String bid, String pid, String cid) async {
    try {
      isRepairTableLoading(true);
      final response = await RepairTableService.fetchRepairTableData(bid, pid, cid);
      _appRepairTableData = response;

      // Store the list of repair devices
      repairDevices.value = response.table ?? [];

      // If there's at least one device in the list, extract its RAM/ROM
      if (repairDevices.isNotEmpty) {
        ramId = repairDevices.first.ramId;
        romId = repairDevices.first.romId;
        print('Extracted RAM ID: $ramId, ROM ID: $romId');
      }
    } finally {
      isRepairTableLoading(false);
      update();
    }
  }

  void addService(Table1 service) {
    if (!selectedServices.contains(service)) {
      selectedServices.add(service);
      totalPrice.value += (service.price ?? 0).toInt();
      update();
    }
  }

  void removeService(Table1 service) {
    if (selectedServices.contains(service)) {
      selectedServices.remove(service);
      totalPrice.value -= (service.price ?? 0).toInt();
      update();
    }
  }

  bool isServiceSelected(Table1 service) {
    return selectedServices.contains(service);
  }

  // Helper methods to access RAM/ROM externally
  String? getRamId() => ramId;
  String? getRomId() => romId;
}