import 'package:fonofy/Api_Service/OrderService/OrderDetailServices.dart';
import 'package:fonofy/models/OrderProductModel/OrderProductModel.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  var isLoading = true.obs;
  var products = <OrderProductModel>[].obs;
  var orderDetail = Rxn<OrderDetailModel>();

  Future<void> loadOrderDetails(String orderId, String customerId) async {
    try {
      isLoading(true);
      products.value = await OrderDetailService.fetchOrderProducts(orderId, customerId);
      orderDetail.value = await OrderDetailService.fetchOrderDetails(orderId);
    } catch (e) {
      // print('Error loading order data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> cancelOrder(String orderId, String customerId, String comment) async {
    try {
      isLoading(true);
      bool success = await OrderDetailService.cancelOrder(orderId, comment);
      if (success) {
        Get.snackbar('Success', 'Order cancelled successfully');
        await loadOrderDetails(orderId, customerId); // Use passed customerId
      } else {
        Get.snackbar('Error', 'Failed to cancel order');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }
}
