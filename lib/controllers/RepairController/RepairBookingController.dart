import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Api_Service/SellService/RepairColorModelService/RepairBookingService.dart';
import '../../model/RepairModel/RepairBookingModel.dart';

// class RepairBookingController extends GetxController {
//   var isLoading = false.obs;
//   var isBooked = false.obs;
//
//   Future<void> bookRepair(RepairBookingModel model, String token) async {
//     try {
//       isLoading.value = true;
//       final response = await RepairBookingService.submitRepairBooking(
//         token: token,
//         bookingModel: model,
//       );
//
//       if (response['success'] == true) {
//         isBooked.value = true;
//         Get.snackbar(
//           'Success',
//           'Repair booking successful',
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//       } else {
//         isBooked.value = false;
//         final errors = response['errors'] as List<dynamic>;
//         print('API Errors: $errors');
//         Get.snackbar(
//           'Error',
//           errors.isNotEmpty ? errors.join(', ') : 'Failed to book repair',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       isBooked.value = false;
//       print('Booking Exception: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to book repair: $e',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }



class RepairBookingController extends GetxController {
  RxBool isLoading = false.obs;

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
    required double totalMRP,
    required double totalPrice,
    required double totalAmount,
    required double totalDiscount,
    required double deliveryCharge,
    required dynamic couponId,
    required String couponName,
    required String couponDiscountType,
    required double couponAmount,
    required double couponPercent,
    required String couponCode,
    required String repairType,
    required String slotDate,
    required String remark,
    required String paymentMode,
    required List<RepairDetail> repairDetails,
  }) async {
    isLoading.value = true;

    final repairBookingModel = RepairBookingModel(
      modelId: modelId,
      romId: romId,
      ramId: ramId,
      colorId: colorId,
      customerId: customerId,
      orderId: "",
      servieCharge: 0,
      couponId: couponId,
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
      totalMrp: totalMRP,
      mode: paymentMode,
      repairDetails: repairDetails,
    );
    final success = await RepairBookingService.repairBooking(repairBookingModel);
    if (success) {
      Get.snackbar("Success", "Repair Booking Successful", backgroundColor: Colors.green, colorText: Colors.white);
     }

    isLoading.value = false;
  }
}
