import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/model/RepairModel/BookingRepairModel.dart'; // This has RepairBookingRequestModel
import '../../Api_Service/SellService/RepairColorModelService/RepairBookingService.dart';
import '../../TokenHelper/TokenHelper.dart';

class RepairBookingController extends GetxController {
  RxBool isLoading = false.obs;
  var bookingDetails = Rxn<RepairBookingRequestModel>();

  Future<void> submitRepairBooking({
    required dynamic modelId,
    required dynamic romId,
    required dynamic ramId,
    required dynamic colorId,
    required String customerId,
    required String shippingId,
    required String shippingName,
    required String shippingMobileNo,
    required String shippingEmailId,
    required String shippingAddress,
    required String shippingLandmark,
    required dynamic shippingCity,
    required dynamic shippingState,
    required String shippingPincode,
    required String workType,
    required dynamic totalMRP,
    required dynamic totalPrice,
    required dynamic totalAmount,
    required dynamic totalDiscount,
    required dynamic deliveryCharge,
    required String? couponId,
    required String couponName,
    required String couponDiscountType,
    required dynamic couponAmount,
    required dynamic couponPercent,
    required String couponCode,
    required String repairType,
    required String slotDate,
    // required String slotTime,
    required String remark,
    required dynamic servieCharge,
    required String Mode,
    // required List selectedServices,
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

    final repairBookingModel = RepairBookingRequestModel(
      modelId: int.parse(modelId.toString()),
      romId: romId,
      ramId: ramId,
      colorId: int.parse(colorId.toString()),
      customerId: customerId,
      orderId: '',
      shippingId: shippingId,
      shippingName: shippingName,
      shippingMobileNo: shippingMobileNo,
      shippingEmailId: shippingEmailId,
      shippingAddress: shippingAddress,
      shippingLandmark: shippingLandmark,
      shippingCity: shippingCity,
      shippingState: shippingState,
      shippingPincode: shippingPincode,
      workType: workType,
      couponName: couponName,
      couponDiscountType: couponDiscountType,
      couponAmount: couponAmount,
      couponPercent: couponPercent,
      couponCode: couponCode,
      repairType: repairType,
      slotDate: slotDate,
      remark: remark,
      deliveryCharge: deliveryCharge,
      totalAmount: totalAmount,
      totalPrice: totalPrice,
      totalDiscount: totalDiscount,
      totalMRP: totalMRP,
      servieCharge: servieCharge,
      couponId: int.parse(couponId.toString()),
      Mode: Mode,
      repairDetails: repairDetails,
    );

    bookingDetails.value = repairBookingModel;

    final success = await RepairBookingService.fetchRepairBooking(
        repairBookingModel, token); // ✅ Correct model passed here

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
