import 'package:fonofy/Api_Service/TrackingOrderServices.dart';
import 'package:fonofy/models/TrackingModel/TrackingModel.dart';
import 'package:get/get.dart';


class TrackingController extends GetxController {
  var isLoading = false.obs;
  var trackingList = <TrackingModel>[].obs;

  Future<void> fetchTrackingData(String orderId, String customerId) async {
    try {
      isLoading.value = true;
      final data = await TrackingService.getTrackingData(orderId, customerId);
      trackingList.assignAll(data);
    } catch (e) {
      // print("Error fetching tracking data: $e");
      // Optionally show a snackbar or dialog
    } finally {
      isLoading.value = false;
    }
  }
}

