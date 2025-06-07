import 'package:flutter/material.dart';
import 'package:fonofy/Device/DeviceDetailsScreen3.dart';
import 'package:fonofy/controllers/DeviceQuestions/DeviceQuestionsController.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class DeviceDetailScreen2 extends StatefulWidget {
  const DeviceDetailScreen2({Key? key}) : super(key: key);

  @override
  _DeviceDetailScreen2State createState() => _DeviceDetailScreen2State();
}

class _DeviceDetailScreen2State extends State<DeviceDetailScreen2> {
  final DeviceQuestionnaireController controller =
      Get.put(DeviceQuestionnaireController());

  final Map<String, bool> selectedDefects = {};

  final List<String> staticImages = [
    "assets/images/broken.png",
    "assets/images/DeadSpot.png",
    "assets/images/scratch.png",
    "assets/images/DevicePanelMissing.png",
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

        final defects = controller.questions
            .where((q) => q.pageId == 2)
            .take(4) // only take 4 questions
            .toList();

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select screen/body defect that are applicable!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text("Please provide correct details."),
              const SizedBox(height: 16),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                  children: List.generate(defects.length, (index) {
                    final question = defects[index];
                    selectedDefects.putIfAbsent(question.questionId, () => false);
                    return buildDefectTile(
                      question.questionId,
                      question.question,
                      staticImages[index], // static image used
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
                    Get.to(() => DeviceDetailsScreen3());
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

  Widget buildDefectTile(String key, String label, String imagePath) {
    bool isSelected = selectedDefects[key] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDefects[key] = !isSelected;
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
            Image.asset(imagePath, height: 80, width: 70),
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
