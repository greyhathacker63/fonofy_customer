// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Api_Service/SellService/RepairColorModelService/RepairBookingService.dart';
// import '../../TokenHelper/TokenHelper.dart';
// import '../../model/RepairModel/RepairBookingModel.dart';
//
// class RepairBookingController extends GetxController {
//   RxBool isLoading = false.obs;
//
//   var bookingDetails = Rxn<RepairBookingModel>();
//   Future<void> submitRepairBooking({
//     required dynamic modelId,
//     required dynamic romId,
//     required dynamic ramId,
//     required dynamic colorId,
//     required String customerId,
//     required String shippingId,
//     required String shippingName,
//     required String shippingMobileNo,
//     required String shippingEmailId,
//     required String shippingAddress,
//     required String shippingLandmark,
//     required dynamic shippingCity,
//     required dynamic shippingState,
//     required String shippingPincode,
//     required String workType,
//     required double totalMRP,
//     required double totalPrice,
//     required double totalAmount,
//     required double totalDiscount,
//     required double deliveryCharge,
//     required dynamic couponId,
//     required String couponName,
//     required String couponDiscountType,
//     required double couponAmount,
//     required double couponPercent,
//     required String couponCode,
//     required String repairType,
//     required String slotDate,
//     required String remark,
//     required List<RepairDetail> repairDetails,
//   }) async {
//     isLoading.value = true;
//
//     final token = await TokenHelper.getToken();
//
//     if (token == null || token.isEmpty) {
//       isLoading.value = false;
//       Get.snackbar("Error", "Authentication token missing",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     final repairBookingModel = RepairBookingModel(
//       modelId: modelId,
//       romId: romId,
//       ramId: ramId,
//       colorId: colorId,
//       customerId: customerId,
//       orderId: "",
//       shippingId: shippingId,
//       shippingName: shippingName,
//       shippingMobileNo: shippingMobileNo,
//       shippingEmailId: shippingEmailId,
//       shippingAddress: shippingAddress,
//       shippingLandmark: shippingLandmark,
//       shippingCity: shippingCity,
//       shippingState: shippingState,
//       shippingPincode: shippingPincode,
//       workType: workType,
//       couponPercent: couponPercent,
//       couponCode: couponCode,
//       repairType: repairType,
//       slotDate: slotDate,
//       remark: remark,
//       deliveryCharge: deliveryCharge,
//       totalAmount: totalAmount,
//       totalPrice: totalPrice,
//       totalDiscount: totalDiscount,
//       totalMrp: totalMRP,
//       repairDetails: repairDetails,
//       servieCharge: null,
//       couponId: null,
//       couponName: '',
//       couponDiscountType: '',
//       couponAmount: null,
//       mode: '',
//     );
//
//     final success = await RepairBookingService.fetchRepairBooking(
//         repairBookingModel, token);
//
//     if (success) {
//       Get.snackbar("Success", "Repair Booking Successful",
//           backgroundColor: Colors.green, colorText: Colors.white);
//     } else {
//       Get.snackbar("Error", "Failed to submit repair booking",
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//
//     isLoading.value = false;
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Api_Service/SellService/RepairColorModelService/RepairBookingService.dart';
import '../../TokenHelper/TokenHelper.dart';
import '../../model/RepairModel/RepairBookingModel.dart';

class RepairBookingController extends GetxController {
  RxBool isLoading = false.obs;

  var bookingDetails = Rxn<RepairBookingModel>();

  Future<void> submitRepairBooking({
    required String modelId,
    required String romId,
    required String ramId,
    required String colorId,
    required String customerId,
    required String shippingId,
    required String shippingName,
    required String shippingMobileNo,
    required String shippingEmailId,
    required String shippingAddress,
    required String shippingLandmark,
    required String shippingCity,
    required String shippingState,
    required String shippingPincode,
    required String workType,
    required double totalMRP,
    required double totalPrice,
    required double totalAmount,
    required double totalDiscount,
    required double deliveryCharge,
    required String? couponId,
    required String couponName,
    required String couponDiscountType,
    required double couponAmount,
    required double couponPercent,
    required String couponCode,
    required String repairType,
    required String slotDate,
    required String remark,
    required List<RepairDetail> repairDetails,
  }) async {
    isLoading.value = true;

    final token = await TokenHelper.getToken();
    if (token == null || token.isEmpty) {
      isLoading.value = false;
      Get.snackbar("Error", "Authentication token missing",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final repairBookingModel = RepairBookingModel(
      modelId: modelId,
      romId: romId,
      ramId: ramId,
      colorId: colorId,
      customerId: customerId,
      orderId: "",
      shippingId: shippingId,
      shippingName: shippingName,
      shippingMobileNo: shippingMobileNo,
      shippingEmailId: shippingEmailId,
      shippingAddress: shippingAddress,
      shippingLandmark: shippingLandmark,
      shippingCity: 0,
      shippingState: shippingState,
      shippingPincode: shippingPincode,
      workType: workType,
      couponPercent: couponPercent,
      couponCode: couponCode,
      repairType: repairType,
      slotDate: slotDate,
      remark: remark,
      deliveryCharge: deliveryCharge,
      totalAmount: totalAmount,
      totalPrice: totalPrice,
      totalDiscount: totalDiscount,
      totalMrp: totalMRP,
      repairDetails: repairDetails,
      servieCharge: null,
      couponId: couponId,
      couponName: couponName,
      couponDiscountType: couponDiscountType,
      couponAmount: couponAmount,
      mode: '',
    );

    bookingDetails.value = repairBookingModel;

    final success = await RepairBookingService.fetchRepairBooking(repairBookingModel, token);

    if (success) {
      Get.snackbar("Success", "Repair Booking Successful",
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar("Error", "Failed to submit repair booking",
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    isLoading.value = false;
  }
}
