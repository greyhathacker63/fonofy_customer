import 'package:fonofy/Api_Service/OrderService/CancelSellOrderService.dart';
import 'package:get/get.dart';


class CancelSellOrderController extends GetxController {
  final isLoading = false.obs;
  final cancelMessage = ''.obs;

  Future<void> cancelSellOrder({
    required String orderId,
    required String customerId,
    required String reason,
    required String reasonId,
    required String reasonRemark,
  }) async {
    try {
      isLoading.value = true;
      final responseMessage = await CancelSellOrderService.cancelOrder(
        orderId: orderId,
        customerId: customerId,
        reason: reason,
        reasonId: reasonId,
        reasonRemark: reasonRemark,
      );
      cancelMessage.value = responseMessage;
    } catch (e) {
      cancelMessage.value = 'Failed to cancel sell order';
    } finally {
      isLoading.value = false;
    }
  }
}
