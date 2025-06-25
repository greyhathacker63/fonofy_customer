import 'package:flutter/material.dart';
 import 'package:fonofy/Api_Service/SellService/SellCancelOrderService.dart';
import 'package:fonofy/model/SellModel/SellCancelOrderModel.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../utils/Colors.dart';

class SellCancelOrderController extends GetxController {
  var isLoading = false.obs;
  var cancelSellMessage = ''.obs;

  Future<void> cancelSellOrder({
    required String orderId,
    required String customerId,
    required String reason,
    required dynamic reasonId,
    required String reasonRemark,
  }) async {
    try {
      isLoading(true);
      final result = await SellCancelOrderService.cancelSellOrder(
          orderId: orderId,
          customerId: customerId,
          reason: reason,
          reasonId: reasonId,
          reasonRemark: reasonRemark
      );

      if (result != null) {
        cancelSellMessage.value = result.message;
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