import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/SellCalculatorService.dart';
import 'package:fonofy/model/SellCalculationModel.dart';
import 'package:get/get.dart';


class SellCalculatorController extends GetxController {
  final SellCalculatorService _service = SellCalculatorService();

  var isLoading = true.obs;
  var _getSellCalcData;


  PriceEvaluation? get mSellPhoneListData => _getSellCalcData;

  Future<void> calculatePrice( { required List<double> questWeights,
    required double basePrice}) {
    return _service.calculateSellPrice(basePrice: basePrice, questWeights: questWeights)
        .then((response) {
          isLoading(true);
          _getSellCalcData = response;
        })
        .catchError(
            (err) => debugPrint('Error in Sell Price Data!!!!! : $err'))
        .whenComplete(() => isLoading(false));
  }
}
