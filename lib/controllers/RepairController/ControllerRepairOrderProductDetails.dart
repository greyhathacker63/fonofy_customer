// // lib/controllers/RepairController/RepairOrderProductDetailsController.dart
// import 'package:get/get.dart';
// import 'package:fonofy/model/RepairModel/RepairOrderProductDetailsModel.dart';
//
// import '../../Api_Service/SellService/RepairColorModelService/RepairOrderProductDetailsServices.dart';
//
// class RepairOrderProductDetailsController extends GetxController {
//   var isLoading = false.obs;
//   var detailsRepairOrderProduct = Rxn<RepairOrderProductDetailsModel>();
//
//   Future<void> getRepairOrderProductDetails({
//     required String orderId,
//     required String customerId,
//
//   }) async {
//     try {
//        isLoading.value = true;
//       final result = await RepairOrderProductDetailsService.fetchRepairOrderProductDetails(
//         orderId: orderId,
//         customerId: customerId,
//       );
//        detailsRepairOrderProduct.value = result;
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }


import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/RepairModel/RepairOrderProductDetailsModel.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Api_Service/SellService/RepairColorModelService/RepairOrderProductDetailsServices.dart';

class RepairOrderProductDetailsController extends GetxController {
  var isLoading = true.obs;
  var detailsRepairOrderProduct = Rxn<RepairOrderProductDetailsModel>();

  Future<void> getRepairOrderProductDetails({
    required String orderId,
    required String customerId,
  }) async {
    try {
      isLoading.value = true;

      final token = await TokenHelper.getToken();
      if (token == null || token.isEmpty) {
        print('Token is null or empty. User might not be logged in.');
        return;
      }
      final response = await RepairOrderProductDetailsService.fetchRepairOrderProductDetails(
        orderId: orderId,
        customerId: customerId,
        token: token,
      );
      detailsRepairOrderProduct.value = response;
    } catch (e) {
      print('Error fetching repair order details: $e');
      detailsRepairOrderProduct.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}

