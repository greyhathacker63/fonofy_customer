import 'package:flutter/material.dart';
import 'package:fonofy/Device/DeviceDetailsScreen4.dart';
import 'package:fonofy/controllers/DeviceQuestions/DeviceQuestionsController.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class DeviceDetailsScreen3 extends StatefulWidget {
  @override
  _DeviceDetailsScreen3State createState() => _DeviceDetailsScreen3State();
}

class _DeviceDetailsScreen3State extends State<DeviceDetailsScreen3> {
  final DeviceQuestionnaireController controller =
      Get.put(DeviceQuestionnaireController());

  Map<String, bool> selectedIssues = {};

  final List<String> staticImages = [
    "assets/images/front.png",
    "assets/images/back.png",
    "assets/images/volume.png",
    "assets/images/finger.png",
  ];

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

        final issues = controller.questions
            .where((q) => q.pageId == 3)
            .take(4) // take only 4 questions for 4 static images
            .toList();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select the issue(s) applicable to your device!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text("Please select appropriate conditions."),
              const SizedBox(height: 16),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                  children: List.generate(issues.length, (index) {
                    final question = issues[index];
                    selectedIssues.putIfAbsent(question.questionId, () => false);
                    return buildIssueTile(
                      question.questionId,
                      question.questionTitle,
                      staticImages[index],
                    );
                  }),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appBlueColor3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Get.to(() => DeviceDetailsScreen4());
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildIssueTile(String key, String label, String imagePath) {
    bool isSelected = selectedIssues[key] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIssues[key] = !isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 80,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: isSelected ? Colors.blue : Colors.grey[300],
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
