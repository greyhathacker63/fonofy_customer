import 'package:flutter/cupertino.dart';
import 'package:fonofy/Api_Service/SellService/SellVariantTableService.dart';
import 'package:fonofy/models/SellVariantTableModel/SellVariantTableModel.dart';
import 'package:get/get.dart';

class SellVariantControllerTable extends GetxController {
  var isVariantTableLoading = true.obs;
  var _appVariantTableData;

  SellVariantTableModel? get tableVariantData => _appVariantTableData;

  Future<void> getTableVariantData(
    String modelno,
  ) async {
    await SellVariantTableService.fetchVariantTableData(
      modelno,
    ).then((response) {
      isVariantTableLoading(true);
      _appVariantTableData = response;
      update();
    }).catchError((err) {
      // debugPrint('Options Deatils Error: $err');
    }).whenComplete(() => isVariantTableLoading(false));
  }
}
