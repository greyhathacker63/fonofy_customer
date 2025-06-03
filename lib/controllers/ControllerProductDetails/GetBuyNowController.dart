import 'package:fonofy/Api_Service/AddToCartService/GetBuyNowService.dart';
import 'package:fonofy/model/AddToCartModel/GetBuynowModel.dart';
import 'package:get/get.dart';

// class ControllerGetBuyNowDetails extends GetxController {
//   var getBuyNowDetails = Rxn<GetBuyNowModel>();
//   var isLoading = false.obs;
//
//   Future<void> getGetBuyNowData({required String userCode, required String cartRef}) async {
//     try {
//       isLoading.value = true;
//       var response = await GetBuyNowService().fetchGetBuyNowData(customerId: userCode, cartRef: cartRef);
//
//       if (response != null && response.isNotEmpty) {
//         getBuyNowDetails.value = response.first;
//       } else {
//         print("No data returned or list is empty");
//         getBuyNowDetails.value = null;
//       }
//     } catch (e) {
//       print("Error fetching product details: $e");
//       getBuyNowDetails.value = null;
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

class ControllerGetBuyNowDetails extends GetxController {
  final getBuyNowDetails = Rxn<GetBuyNowModel>();
  final isLoading = false.obs;

  Future<void> getGetBuyNowData({
    required String userCode,
    required String cartRef,
  }) async {
    if (userCode.isEmpty || cartRef.isEmpty) {
      print("🚫 userCode or cartRef is empty. Aborting call.");
      return;
    }

    try {
      isLoading.value = true;
      print("📦 Fetching GetBuyNowData -> userCode: $userCode, cartRef: $cartRef");

      final response = await GetBuyNowService().fetchGetBuyNowData(
        customerId: userCode,
        cartRef: cartRef,
      );

      if (response != null) {
        getBuyNowDetails.value = response;
        print("✅ Data Loaded: ${response.productName}");
      } else {
        print("❌ No data found");
        getBuyNowDetails.value = null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      getBuyNowDetails.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
