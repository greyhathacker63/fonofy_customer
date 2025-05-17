import 'package:fonofy/Api_Service/RatingService/RatingService.dart';
import 'package:get/get.dart';


class RatingController extends GetxController {
  var isLoading = false.obs;

  Future<void> submitRating({
    required int productId,
    required String orderId,
    required String description,
    required int rating,
    required int colorId,
    required int ramId,
    required int romId,
  }) async {
    try {
      isLoading.value = true;

      var response = await RatingService.submitRatingApi(
        productId: productId,
        orderId: orderId,
        description: description,
        rating: rating,
        colorId: colorId,
        ramId: ramId,
        romId: romId,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Rating submitted successfully");
      } else {
        Get.snackbar("Error", "Failed to submit rating");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
