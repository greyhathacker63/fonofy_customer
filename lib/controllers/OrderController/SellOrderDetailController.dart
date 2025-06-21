import 'package:fonofy/Api_Service/SellService/SellOrderDetailService.dart';
import 'package:fonofy/model/SellModel/SellOrderDetailModel.dart';
import 'package:get/get.dart';

class SellOrderDetailController extends GetxController {
  var isLoading = true.obs;
  var productDetail = Rxn<SellOrderDetailProduct>();
  var orderInfo = Rxn<SellOrderDetailInfo>();

  Future<void> fetchOrderDetails(String orderId, String customerId) async {
    try {
      isLoading.value = true;
      final data = await SellOrderDetailService.fetchSellOrderDetail(
        orderId: orderId,
        customerId: customerId,
      );
      productDetail.value = data['product'];
      orderInfo.value = data['info'];
    } catch (e) {
      print('Error loading sell order detail: $e');
      productDetail.value = null;
      orderInfo.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
