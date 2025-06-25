// import 'package:fonofy/Api_Service/SellService/SellOrderDetailService.dart';
// import 'package:fonofy/model/SellModel/SellOrderDetailModel.dart';
// import 'package:get/get.dart';
//
// class SellOrderDetailController extends GetxController {
//   var isLoading = true.obs;
//   var productSellDetail = Rxn<SellOrderDetailProduct>();
//   // var orderInfo = Rxn<SellOrderDetailInfo>();
//
//
//
//   Future<void> fetchOrderDetails(String orderId, String customerId) async {
//     try {
//       isLoading.value = true;
//       final data = await SellOrderDetailService.fetchSellOrderDetail(
//         orderId: orderId,
//         customerId: customerId,
//       );
//       productSellDetail.value = data['product'];
 //     } catch (e) {
//       print('Error loading sell order detail: $e');
//       productSellDetail.value = null;
 //     } finally {
//       isLoading.value = false;
//     }
//   }
// }


import 'package:get/get.dart';
import 'package:fonofy/Api_Service/SellService/SellOrderDetailService.dart';
import 'package:fonofy/model/SellModel/SellOrderDetailModel.dart';

class SellOrderDetailController extends GetxController {
  var isLoading = true.obs;

   var productSellDetail = Rxn<SellOrderDetailProduct>();

  Future<void> fetchOrderDetails(String orderId, String customerId) async {
    try {
      isLoading.value = true;

       final result = await SellOrderDetailService.fetchSellOrderDetail(
        orderId: orderId,
        customerId: customerId,
      );
      productSellDetail.value = result;
    } catch (e) {
      print('❌ Error loading sell order detail: $e');
      productSellDetail.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}

