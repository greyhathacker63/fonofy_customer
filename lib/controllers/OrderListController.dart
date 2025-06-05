import 'package:get/get.dart';
import 'package:fonofy/Api_Service/OrderService/OrderListService.dart';
import 'package:fonofy/models/OrderModel/OrderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListController extends GetxController {
  var isLoading = true.obs;
  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    fetchOrderList();
    super.onInit();
  }

 void fetchOrderList() async {
  try {
    isLoading(true);
    var result = await OrderListService.fetchOrders(); 
    orders.assignAll(result);
  } catch (e) {
  } finally {
    isLoading(false);
  }
}
}