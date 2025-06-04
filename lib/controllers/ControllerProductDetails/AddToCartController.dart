// import 'package:fonofy/Api_Service/AddToCartService/AddToCartService.dart';
// import 'package:fonofy/model/AddToCartModel/AddToCartModel.dart';
// import 'package:get/get.dart';
//
//  class AddToCartController extends GetxController{
//    var addToCartDetails = Rxn<AddToCartModel>();
//
//    Future<void> getProductDetailsData() async {
//      try {
//        var response = await AddToCartService.fetchAddToCart(
//            productId: productId,
//            customerId: customerId,
//            quantity: quantity,
//            ramId: ramId,
//            romId: romId,
//            modelId: modelId,
//            colorId: colorId
//        );
//          // Url: url,
//          // Refno: refNo,
//        );
//        if (response.isNotEmpty) {
//
//          productDetails.value = response.first;
//        }
//      } catch (e) {
//        // print("Error fetching product details: $e");
//      }
//    }
//  }