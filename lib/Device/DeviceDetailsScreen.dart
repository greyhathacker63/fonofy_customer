import 'package:flutter/material.dart';
import 'package:fonofy/controllers/DeviceQuestions/DeviceQuestionsController.dart';
import 'package:fonofy/model/SellDevice/DeviceQuestions.dart';
import 'package:get/get.dart';
import 'package:fonofy/Device/DeviceDetailsScreen2.dart';
import 'package:fonofy/utils/Colors.dart';

class DeviceDetailsScreen extends StatefulWidget {
  final String? pid;
  final String bid;
  final String baseprice;
  final String raid;
  final String roid;
  final String? selectedVariant;
  final String modelNo;
  final String ram;
  final String rom;
  final String modelName;

  const DeviceDetailsScreen({
    super.key,
    this.selectedVariant,
    required this.modelNo,
    required this.ram,
    required this.rom,
    this.pid,
    required this.bid,
    required this.raid,
    required this.roid,
    required this.baseprice, required this.modelName,
  });

  @override
  State<DeviceDetailsScreen> createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  final SellQuestionController controller = Get.put(SellQuestionController());
  final Map<String, String?> answers = {};

  @override
  void initState() {
    super.initState();

    controller.loadSellQuestions(
      bid: int.parse(widget.bid),
      pid: int.tryParse(widget.pid ?? '') ?? 1,
      raid: int.parse(widget.raid),
      roid: int.parse(widget.roid),
      model: widget.modelNo,
      ram: widget.ram,
      rom: widget.rom,
      basePrice: widget.baseprice,
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

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final pageData = controller.sellQuestion.value?.data?.firstWhere(
            (d) => d.pageId == 1,
            orElse: () => Datum(questions: []));

        final questions = pageData?.questions ?? [];

        if (questions.isEmpty) {
          return const Center(child: Text("No questions found for this page."));
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
                  ...questions.map(
                    (q) => _buildQuestion(
                      q.questionId ?? '',
                      q.question ?? '',
                      q.questionDescription ?? '',
                      answers[q.questionId] ?? '',
                      (value) {
                        setState(() {
                          answers[q.questionId ?? ''] = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
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
                        final allAnswered = questions.every(
                          (q) => answers[q.questionId ?? ''] != null,
                        );
                        if (allAnswered) {
                          Get.to(() => DeviceDetailScreen2(
                                baseprice: widget.baseprice,
                                bid: widget.bid,
                                raid: widget.raid,
                                roid: widget.roid,
                                modelNo: widget.modelNo,
                                ram: widget.ram,
                                rom: widget.rom,
                                modelName:widget.modelName
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please answer all questions."),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
    String questionId,
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
