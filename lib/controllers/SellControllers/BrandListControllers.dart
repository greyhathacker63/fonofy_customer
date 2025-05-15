//
// import 'package:flutter/material.dart';
// import 'package:fonofy/Api_Service/SellService/BrandListSerice.dart';
// import 'package:fonofy/model/SellModel/BrandListModel.dart';
// import 'package:get/get.dart';
//
//
// class  BrandListController extends GetxController{
//   var isBrandListLoading = true.obs;
//   var _appBrandData;
//
//   BrandListModel? get brandListData => _appBrandData;
//
//   Future<void> getBrandListData() async {
//     await BrandListService.fetchBrandList()
//         .then((response) {
//       isBrandListLoading(true);
//       _appBrandData = response;
//       update();
//     }).catchError((err) => debugPrint('Options Deatils Error: $err'))
//         .whenComplete(() => isBrandListLoading(false));
//   }
// }

import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/BrandListSerice.dart';
import 'package:fonofy/model/SellModel/BrandListModel.dart';
import 'package:get/get.dart';



class BrandListController extends GetxController {
  var isBrandListLoading = true.obs;
  List<BrandListModel> _brandList = [];

  List<BrandListModel> get brandList => _brandList;

  Future<void> getBrandListData() async {
    isBrandListLoading.value = true;
    try {
      _brandList = await BrandListService.fetchBrandList();
    } catch (err) {
      debugPrint('Brand List Error: $err');
    } finally {
      isBrandListLoading.value = false;
      update(); // Notify UI
    }
  }
}
