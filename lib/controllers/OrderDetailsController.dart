import 'package:fonofy/Api_Service/OrderService/OrderDetailServices.dart';
import 'package:fonofy/model/OrderModel/OrderProduct&DetailModel.dart';
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
      print('Error loading order data: $e');
    } finally {
      isLoading(false);
    }
  }
}
