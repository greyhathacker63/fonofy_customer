
import 'dart:convert';
import 'dart:io';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:fonofy/pages/OrderThankYouScreen/OrderThankYouScreen.dart';
import 'package:fonofy/controllers/api_controller.dart';
import 'package:fonofy/models/OrderDetailsForPayModel/OrderDetailsForPayModel.dart';
import 'package:fonofy/models/OrderPaymentModel/OrderPaymentModel.dart';
import 'package:get/get.dart';
 import '../../pages/PaymentScreen/PaymentScreen.dart';
import '../../models/CreateOrderModel/CreateOrderModel.dart';

class CreateOrderController extends GetxController {

  RxBool isLoading = false.obs;



  Future<void> placeOrder({
    required String customerId,
    required String shippingId,
    required String name,
    required String mobileNo,
    required String emailId,
    required String address,
    required String landmark,
    required dynamic city,
    required dynamic state,
    required String pincode,
    required String workType,
    required double totalMRP,
    required double totalPrice,
    required double totalAmount,
    required double totalDiscount,
    required double deliveryCharge,
    required dynamic couponId,
    required double couponAmount,
    required List<OrderProductList> productList,
    required String selectedPaymentMethod,
  }) async {
    isLoading.value = true;
    try {
      CreateOrderModel model = CreateOrderModel(
        customerId: customerId,
        orderId: "",
        orderStatus: "",
        shippingId: shippingId,
        name: name,
        mobileNo: mobileNo,
        emailId: emailId,
        address: address,
        landmark: landmark,
        city: city,
        state: state,
        pincode: pincode,
        workType: workType,
        notes: "",
        couponType: "",
        transactionId: "",
        loginType: "",
        orderOn: Platform.isAndroid?"android":"ios",
        orderType: "",
        totalMrp: totalMRP,
        totalPrice: totalPrice,
        totalAmount: totalAmount,
        totalDiscount: totalDiscount,
        deliveryCharge: deliveryCharge,
        couponId: couponId,
        couponAmount: couponAmount,
        orderProductLists: productList,
      );
      var response = await ApiController.post(url: createOrderUrl, body: model.toJson());
      if(response.statusCode == 200){
        var orderId = jsonDecode(response.body);

        var orderResponse = await ApiController.get(url: '$createOrderForPayUrl?OrderId=$orderId');
        if(orderResponse.statusCode == 200){
          var orderData = jsonDecode(orderResponse.body);
          var orderDetails = OrderDetailsForPayModel.fromJson(orderData);
          var paymentData = OrderPaymentModel(paymentId: orderDetails.paymentId??"", customerId: orderDetails.customerId??"", orderType: orderDetails.orderType??"", orderId: orderDetails.orderId??"", paymentAmount: orderDetails.totalAmount??"");
          var paymentResponse = await ApiController.post(url: orderPaymentUrl, body: paymentData.toJson());
          isLoading.value = false;
          if(selectedPaymentMethod=="Cash on Delivery"&&paymentResponse.statusCode == 200){
            Get.off(OrderThankYouScreen(orderId: orderDetails.orderId ?? '',));
          }
          else if(paymentResponse.statusCode == 200){
            // Get.off(OrderThankYouScreen(orderId: orderDetails.orderId ?? '',));
            Get.off(PaymentScreen(orderId: orderDetails.orderId ?? '', totalAmount: orderDetails.totalAmount, name: orderDetails.shippingName ?? '', phone: orderDetails.shippingMobileNo ?? '',));
          }
        }
      }
    } catch (e) {
      isLoading.value = false;
    }
  }
}