import 'package:fonofy/Api_Service/SellService/SellOrderListService.dart';
import 'package:get/get.dart';
import 'package:fonofy/model/SellModel/SellModel.dart';

class SellOrderListController extends GetxController {
  var isLoading = true.obs;

  var sellOrdersList = <SellModel>[].obs;

  Rx<SellModel?> sellOrder = Rx<SellModel?>(null);

  Future<void> fetchSellOrders(String customerId) async {
    try {
      isLoading.value = true;
      final orders = await SellOrderListService.fetchSellOrdersList(customerId);
      sellOrdersList.assignAll(orders);
    } catch (e) {
      print("Error fetching sell orders: $e");
      sellOrdersList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
