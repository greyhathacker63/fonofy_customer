import 'package:get/get.dart';

import '../../Api_Service/SellService/RepairColorModelService/RepairOrderListService.dart';
import '../../model/RepairModel/RepairOderListModel.dart';


class RepairOrderListController extends GetxController {
  var isLoading = false.obs;

  var repairOrdersList = <RepairOderListModel>[].obs;

  var repairOderList = Rxn<RepairOderListModel>();

  Future<void> getRepairOrdersList(String customerId) async {
    try {
      isLoading.value = true;
      final orders = await RepairOrderListService.fetchRepairOrdersList(customerId);
      repairOrdersList.assignAll(orders);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}





