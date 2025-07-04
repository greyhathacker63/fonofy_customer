

import 'package:fonofy/Api_Service/ProductDetailsService/ProductDetailsService.dart';
import 'package:fonofy/models/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:get/get.dart';

class ControllerProductDetails extends GetxController {
  var productDetails = Rxn<ProductDetailsModel>();

  Future<void> getProductDetailsData({required String url, required String refNo}) async {
    try {
      var response = await ProductDetailsService().fetchProductDetailsData(
        Url: url,
        Refno: refNo,
      );
      if (response.isNotEmpty) {
        productDetails.value = response.first;
      }
    } catch (e) {
    }
  }

  void updateProductVariant({
    required String ramName,
    required String romName,
    required String colorName,
    required double? sellingPrice,
    required String ramId,
    required String romId,
    required String colorId,
    required dynamic discountPercentage,
  }) {
    if (productDetails.value != null) {
      productDetails.value = ProductDetailsModel(
        modelNo: productDetails.value!.modelNo,
        modelUrl: productDetails.value!.modelUrl,
        ucode: productDetails.value!.ucode,
        productAndModelName: productDetails.value!.productAndModelName,
        ramId: ramId,
        ramName: ramName,
        romId: romId,
        romName: romName,
        colorId: colorId,
        colorName: colorName,
        discountPercentage: discountPercentage,
        sellingPrice: sellingPrice,
        sellingPriceF1: productDetails.value!.sellingPriceF1,
        sellingPriceF2: productDetails.value!.sellingPriceF2,
        sellingPricePlus: productDetails.value!.sellingPricePlus,
        newModelAmt: productDetails.value!.newModelAmt,
        stockQuantity: productDetails.value!.stockQuantity,
        display: productDetails.value!.display,
        battery: productDetails.value!.battery,
        rearCamera: productDetails.value!.rearCamera,
        frontCamera: productDetails.value!.frontCamera,

       );
    }
  }
}