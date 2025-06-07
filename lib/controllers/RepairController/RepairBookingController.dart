import 'package:get/get.dart';

import '../../Api_Service/SellService/RepairColorModelService/RepairBookingService.dart';
import '../../model/RepairModel/RepairBookingModel.dart';


class RepairBookingController extends GetxController {
  var isLoading = false.obs;
  var isBooked = false.obs;

  Future<void> bookRepair(RepairBookingModel model, String token) async {
    isLoading.value = true;
    final result = await RepairBookingService.submitRepairBooking( token: token, bookingModel: model);
    isBooked.value = result;
    isLoading.value = false;

    if (result) {
      Get.snackbar('Success', 'Repair booking successful');
    } else {
      Get.snackbar('Error', 'Failed to book repair');
    }
  }
}
