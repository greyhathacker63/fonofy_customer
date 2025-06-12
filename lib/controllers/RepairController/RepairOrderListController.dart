import 'package:get/get.dart';

import '../../Api_Service/SellService/RepairColorModelService/RepairOrderListService.dart';
import '../../model/RepairModel/RepairOderListModel.dart';


class RepairOrderController extends GetxController {
  var isLoading = false.obs;
  var repairOrders = <RepairOderListModel>[].obs;

  Future<void> loadRepairOrders(String customerId) async {
    try {
      isLoading.value = true;
      final orders = await RepairOrderListService.fetchRepairOrdersList(customerId);
      repairOrders.assignAll(orders);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
