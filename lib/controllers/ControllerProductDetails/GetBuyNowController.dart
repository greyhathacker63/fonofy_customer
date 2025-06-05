import 'package:fonofy/Api_Service/AddToCartService/GetBuyNowService.dart';
import 'package:fonofy/models/GetBuyNowModel/GetBuynowModel.dart';
import 'package:get/get.dart';



class ControllerGetBuyNowDetails extends GetxController {
  final getBuyNowDetails = Rxn<GetBuyNowModel>();
  final isLoading = false.obs;

  Future<void> getGetBuyNowData({
    required String userCode,
    required String cartRef,
  }) async {
    if (userCode.isEmpty || cartRef.isEmpty) {
      return;
    }

    try {
      isLoading.value = true;

      final response = await GetBuyNowService().fetchGetBuyNowData(
        customerId: userCode,
        cartRef: cartRef,
      );

      if (response != null) {
        getBuyNowDetails.value = response;
      } else {
        getBuyNowDetails.value = null;
      }
    } catch (e) {
      getBuyNowDetails.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
