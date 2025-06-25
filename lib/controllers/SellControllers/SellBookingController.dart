import 'package:fonofy/Api_Service/SellService/SellBooking/SellBookingService.dart';
import 'package:fonofy/model/SellDevice/SellBookingModel.dart';
import 'package:get/get.dart';

class SellBookingController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<bool> submitSellBooking(Sellbookingmodel booking) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await SellBookingService.postSellBooking(booking);
      if (result) {
        return true;
      } else {
        errorMessage.value = 'Failed to submit booking. Please try again.';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
