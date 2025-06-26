import 'package:fonofy/Api_Service/SellService/DeviceQuestionsService/DevicequestionnaireService.dart';
import 'package:fonofy/model/SellDevice/DeviceQuestions.dart';
import 'package:get/get.dart';

class SellQuestionController extends GetxController {
  final SellQuestionService _service = SellQuestionService();

  var isLoading = false.obs;
  var sellQuestion = SellQuestionModel().obs;

  var errorMessage = ''.obs;

   final selectedOptions = <String, Option>{}.obs;

  void selectOption(String questionId, Option option) {
    selectedOptions[questionId] = option;
  }

  List<double> getSelectedWeights() {
    return selectedOptions.values
        .map<double>((option) => (option.weightage ?? 1.0).toDouble())
        .toList();
  }

  Future<void> loadSellQuestions({
    required dynamic bid,
    required dynamic pid,
    required dynamic raid,
    required dynamic roid,
    required String model,
    required String ram,
    required String rom,
    required String basePrice,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _service.fetchSellQuestions(
        bid: bid,
        pid: pid,
        raid: raid,
        roid: roid,
        model: model,
        ram: ram,
        rom: rom,
        basePrice: basePrice,
      );

      if (result != null) {
        sellQuestion.value = result;
      } else {
        errorMessage.value = 'Failed to fetch data';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
