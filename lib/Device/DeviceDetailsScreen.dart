import 'package:flutter/material.dart';
import 'package:fonofy/controllers/DeviceQuestions/DeviceQuestionsController.dart';
import 'package:get/get.dart';
import 'package:fonofy/Device/DeviceDetailsScreen2.dart';

import 'package:fonofy/utils/Colors.dart';

class DeviceDetailsScreen extends StatefulWidget {
  const DeviceDetailsScreen({Key? key}) : super(key: key);

  @override
  _DeviceDetailsScreenState createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  final DeviceQuestionnaireController controller =
      Get.put(DeviceQuestionnaireController());
  final Map<String, String?> answers = {}; // ✅ Corrected
// Map<QuestionId, Answer>

  // Dummy values – pass real ones or get via constructor
  final int bid = 2;
  final int pid = 14;
  final int raid = 9;
  final int roid = 15;
  final String model = "iphone 13";
  final int ram = 8;
  final int rom = 256;
  final int basePrice = 65000;

  @override
  void initState() {
    super.initState();
    controller.fetchQuestions(
      bid: bid,
      pid: pid,
      raid: raid,
      roid: roid,
      model: model,
      ram: ram,
      rom: rom,
      basePrice: basePrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Filter only questions with pageId == 1
        final filteredQuestions =
            controller.questions.where((q) => q.pageId == 1).toList();

        if (filteredQuestions.isEmpty) {
          return const Center(child: Text("No questions found."));
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tell us more about your device?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Please answer a few questions about your device.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),

                  // Dynamic Questions
                  ...filteredQuestions.map((q) => _buildQuestion(
                        q.questionId, // this is a String
                        q.questionTitle,
                        q.questionDescription,
                        answers[q.questionId],
                        (value) {
                          setState(() {
                            answers[q.questionId] = value;
                          });
                        },
                      )),

                  const SizedBox(height: 20),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.appBlueColor3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        final allAnswered = filteredQuestions.every(
                          (q) => answers[q.questionId] != null,
                        );
                        if (allAnswered) {
                          Get.to(() => DeviceDetailScreen2());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please answer all questions.")),
                          );
                        }
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQuestion(
    String questionId, // changed from int
    String title,
    String description,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text("Yes"),
                value: "Yes",
                groupValue: selectedValue,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text("No"),
                value: "No",
                groupValue: selectedValue,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
