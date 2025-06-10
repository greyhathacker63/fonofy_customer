// import 'package:get/get.dart';
//
// import '../../Api_Service/SellService/RepairColorModelService/RepairBookingService.dart';
// import '../../model/RepairModel/RepairBookingModel.dart';
//
//
// class RepairBookingController extends GetxController {
//   var isLoading = false.obs;
//   var isBooked = false.obs;
//
//   Future<void> bookRepair(RepairBookingModel model, String token) async {
//     isLoading.value = true;
//     final result = await RepairBookingService.submitRepairBooking( token: token, bookingModel: model);
//     isBooked.value = result;
//     isLoading.value = false;
//
//     if (result) {
//       Get.snackbar('Success', 'Repair booking successful');
//     } else {
//       Get.snackbar('Error', 'Failed to book repair');
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Api_Service/SellService/RepairColorModelService/RepairBookingService.dart';
import '../../model/RepairModel/RepairBookingModel.dart';

import 'package:get/get.dart';
import '../../Api_Service/SellService/RepairColorModelService/RepairBookingService.dart';
import '../../model/RepairModel/RepairBookingModel.dart';

class RepairBookingController extends GetxController {
  var isLoading = false.obs;
  var isBooked = false.obs;

  Future<void> bookRepair(RepairBookingModel model, String token) async {
    try {
      isLoading.value = true;
      final result = await RepairBookingService.submitRepairBooking(token: token, bookingModel: model);
      isBooked.value = result;
      if (result) {
        Get.snackbar('Success', 'Repair booking successful',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Failed to book repair. Please check your inputs.',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to book repair: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}