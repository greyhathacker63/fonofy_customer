
import 'package:fonofy/Api_Service/SellService/RepairColorModelService/ServiceRepair.dart';
import 'package:fonofy/model/RepairModel/BookingRepairModel.dart';
import 'package:get/get.dart';

class RepairBookingController extends GetxController {
  var isLoading = false.obs;

  Future<void> submitRepairBooking(RepairBookingRequest request) async {
    try {
      isLoading.value = true;
      await RepairBookingService.postRepairBooking(request);
      Get.snackbar('Success', 'Repair booking successful');
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Repair booking failed');
    } finally {
      isLoading.value = false;
    }
  }
}
