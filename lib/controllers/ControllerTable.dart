import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api_Service/BuyScreenDataService/BuyTableService.dart';
import '../models/ByScreenTableModel/ByScreenTableModel.dart';

class ControllerTable extends GetxController {
  var isTableOptionsLoading = true.obs;
  var _appTableOptionsData;

  ByTableModel? get tableOptionsData => _appTableOptionsData;

  Future<void> getTableOptionsData() async {
    await BuyTableService.fetchBuyTableData().then((response) {
      isTableOptionsLoading(true);
      _appTableOptionsData = response;
      update();
    }).catchError((err) {
      // debugPrint('Options Deatils Error: $err');
    }).whenComplete(() => isTableOptionsLoading(false));
  }
}
