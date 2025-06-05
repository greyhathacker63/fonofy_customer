import 'package:get/get.dart';
import 'package:fonofy/models/DeliveryPinCodeModel/DeliveryPinCodeModel.dart';
import '../../Api_Service/DeliveryPinCodeService/DeliveryPinCodeService.dart';

class DeliveryPinCodeController extends GetxController {
  var isLoading = false.obs;
  var deliveryPinCodeModel = Rxn<DeliveryPinCodeModel>();
  var errorMessage = ''.obs;

  Future<void> fetchPinCode(String pinCode) async {
    isLoading.value = true;
    errorMessage.value = '';
    deliveryPinCodeModel.value = null;

    try {
      final result = await DeliveryPinCodeService.fetchPinCodeDetails(pinCode);
      if (result != null && result.deliveryCodes != null && result.deliveryCodes!.isNotEmpty) {
        final postalCode = result.deliveryCodes!.first.postalCode;
        if (postalCode != null && postalCode.prePaid == "Y") {
          deliveryPinCodeModel.value = result;
        } else {
          errorMessage.value = 'Delivery not available for this PIN code.';
        }
      } else {
        errorMessage.value = 'No delivery available..';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching delivery data.';
    } finally {
      isLoading.value = false;
    }
  }
}
