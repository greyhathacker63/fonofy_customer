import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../Api_Service/AddToCartService/CreateOrderService.dart';
import '../model/AddToCartModel/CreateOrderModel.dart';

// class CreateOrderController extends GetxController {
//   var isLoading = false.obs;
//   var isOrderPlaced = false.obs;
//
//   Future<void> submitOrder(CreateOrderModel createModel) async {
//     isLoading.value = true;
//     isOrderPlaced.value = false;
//
//     final success = await CreateOrderService.createOrder(createModel);
//
//     if (success) {
//       isOrderPlaced.value = true;
//       Get.snackbar("Success", "Order placed successfully!",
//           backgroundColor: Colors.green, colorText: Colors.white);
//     } else {
//       Get.snackbar("Error", "Failed to place order. Please try again.",
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//
//     isLoading.value = false;
//   }
// }




import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ProductDetailsService/ProductDetailsService.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductImageListModel.dart';
import 'package:get/get.dart';

class CreateOrderController extends GetxController {

  var productDetails = Rxn<CreateOrderModel>();

  Future<void> getCreateOrderData({required String url, required String refNo}) async {
    try {
      var response = await CreateOrderService().fetchCreateOrderData(
          customerId: '', shippingId: '', name: '', mobileNo: '', emailId: '', address: '', city: '', state: '', pincode: '', workType: ''

      );
      if (response.isNotEmpty) {
        productDetails.value = response.first;
      }
    } catch (e) {
      print("Error fetching product details: $e");
    }
  }
}

