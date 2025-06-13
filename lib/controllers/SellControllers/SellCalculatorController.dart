import 'package:fonofy/Api_Service/SellService/SellCalculatorService.dart';
import 'package:get/get.dart';


class SellCalculatorController extends GetxController {
  final SellCalculatorService _service = SellCalculatorService();

  var isLoading = false.obs;
  var basePrice = 0.0.obs;
  var weightedScore = 0.0.obs;
  var finalPrice = 0.0.obs;

  Future<void> calculate({
    required List<double> questWeights,
    required double inputBasePrice,
  }) async {
    isLoading.value = true;

    final result = await _service.calculateSellPrice(
      questWeights: questWeights,
      basePrice: inputBasePrice,
    );

    if (result != null) {
      basePrice.value = result["BasePrice"];
      weightedScore.value = result["WeightedScore"];
      finalPrice.value = result["FinalPrice"];
    }

    isLoading.value = false;
  }
}
