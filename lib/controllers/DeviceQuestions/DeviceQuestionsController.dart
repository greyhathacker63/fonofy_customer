import 'package:fonofy/Api_Service/SellService/DeviceQuestionsService/DevicequestionnaireService.dart';
import 'package:fonofy/model/SellDevice/DeviceQuestions.dart';
import 'package:get/get.dart';


class SellQuestionController extends GetxController {
  final SellQuestionService _service = SellQuestionService();

  var isLoading = false.obs;
  var sellQuestion = Rxn<SellQuestion>();
  var errorMessage = ''.obs;

  Future<void> loadSellQuestions({
    required int bid,
    required int pid,
    required int raid,
    required int roid,
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
        rom: rom ,
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
