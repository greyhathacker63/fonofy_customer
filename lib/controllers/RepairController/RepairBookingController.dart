import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Api_Service/SellService/RepairColorModelService/RepairBookingService.dart';
import '../../model/RepairModel/RepairBookingModel.dart';

class RepairBookingController extends GetxController {
  var isLoading = false.obs;
  var isBooked = false.obs;

  Future<void> bookRepair(RepairBookingModel model, String token) async {
    try {
      isLoading.value = true;
      final response = await RepairBookingService.submitRepairBooking(
        token: token,
        bookingModel: model,
      );

      if (response['success'] == true) {
        isBooked.value = true;
        Get.snackbar(
          'Success',
          'Repair booking successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        isBooked.value = false;
        final errors = response['errors'] as List<dynamic>;
        print('API Errors: $errors');
        Get.snackbar(
          'Error',
          errors.isNotEmpty ? errors.join(', ') : 'Failed to book repair',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isBooked.value = false;
      print('Booking Exception: $e');
      Get.snackbar(
        'Error',
        'Failed to book repair: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}