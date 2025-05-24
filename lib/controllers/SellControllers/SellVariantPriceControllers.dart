import 'package:flutter/cupertino.dart';
import 'package:fonofy/Api_Service/SellService/SellVariantPriceService.dart';
import 'package:fonofy/model/SellModel/SellVariantPriceModel.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SellVariantControllerPrice extends GetxController{

  var isVariantPriceLoading = true.obs;
  var _appVariantPriceData;

  SellVariantPriceModel? get priceVariantData => _appVariantPriceData;

  Future<void> getPriceVariantData(String modelNo,String ram,String rom ) async {
    await SellVariantPriceService.fetchVariantPriceData(modelNo,ram,rom).then((response) {
      isVariantPriceLoading(true);
      _appVariantPriceData = response;
      update();
    })
        .catchError((err) => debugPrint('Options Deatils Error: $err'))
        .whenComplete(() => isVariantPriceLoading(false));
  }
}
