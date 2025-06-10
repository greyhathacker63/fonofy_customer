import 'package:fonofy/Api_Service/SellService/DeviceQuestionsService/DevicequestionnaireService.dart';
import 'package:fonofy/model/SellDevice/DeviceQuestions.dart';
import 'package:get/get.dart';

class DeviceQuestionnaireController extends GetxController {
  var pages = <PageDetails>[].obs;
  var mappings = <PageQuestionMapping>[].obs;
  var questions = <QuestionDetails>[].obs;
  var isLoading = false.obs;

  Future<void> fetchQuestions({
    required int bid,
    required int pid,
    required int raid,
    required int roid,
    required String model,
    required int ram,
    required int rom,
    required int basePrice,
  }) async {
    try {
      isLoading.value = true;
      final response = await DeviceQuestionnaireService.fetchDeviceQuestions(
        bid: bid,
        pid: pid,
        raid: raid,
        roid: roid,
        model: model,
        ram: ram,
        rom: rom,
        basePrice: basePrice,
      );
      pages.assignAll(response.table);
      mappings.assignAll(response.table1);
      questions.assignAll(response.table2);
    } catch (e) {
      print("प्रश्नावली प्राप्त करने में त्रुटि: $e");
      Get.snackbar("त्रुटि", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
