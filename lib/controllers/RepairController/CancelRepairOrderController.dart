import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Api_Service/SellService/RepairColorModelService/CancelRepairOrderService.dart';
import '../../utils/Colors.dart';

class CancelRepairOrderController extends GetxController {
  var isLoading = false.obs;
  var cancelMessage = ''.obs;

  Future<void> cancelRepairOrder({
    required String orderId,
    required String customerId,
    required String reasone,
    required dynamic reasonId,
    required String reasonRemark,
  }) async {
    try {
      isLoading(true);
      final result = await CancelRepairOrderService.cancelRepairOrder(
        orderId: orderId,
        customerId: customerId,
        reasone: reasone,
        reasonId: reasonId,
        reasonRemark: reasonRemark,
       );

      if (result != null) {
        cancelMessage.value = result.message;
        Get.snackbar("Success",
          result.message,
          backgroundColor: ColorConstants.appBlueColor3,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to cancel order",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    }  finally {
      isLoading(false);
    }
  }
}
