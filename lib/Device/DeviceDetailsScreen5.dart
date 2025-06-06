import 'package:flutter/material.dart';
import 'package:fonofy/YourDevice/YourDevice.dart';
import 'package:fonofy/controllers/DeviceQuestions/DeviceQuestionsController.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class DeviceDetailsScreen5 extends StatefulWidget {
  const DeviceDetailsScreen5({super.key});

  @override
  State<DeviceDetailsScreen5> createState() => _DeviceDetailsScreen5State();
}

class _DeviceDetailsScreen5State extends State<DeviceDetailsScreen5> {
  final DeviceQuestionnaireController controller =
      Get.put(DeviceQuestionnaireController());

  final Map<String, bool> selectedAccessories = {};

  final List<String> staticImages = [
    "assets/images/charger.png",
    "assets/images/boximei.png",
    "assets/images/earphones.png",
    "assets/images/cable.png",
    "assets/images/default1.png",
    "assets/images/default2.png",
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
        title:
            const Text("Device Details", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final questions = controller.questions
            .where((q) => q.pageId == 5)
            .toList();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Do you have the following?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "Please select accessories which are available",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),

              // Accessories as cards
              Expanded(
                child: GridView.builder(
                  itemCount: questions.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final q = questions[index];
                    final imagePath = index < staticImages.length
                        ? staticImages[index]
                        : "assets/images/default.png";

                    selectedAccessories.putIfAbsent(q.questionId, () => false);

                    return _buildAccessoryCard(
                      imagePath,
                      q.questionTitle,
                      selectedAccessories[q.questionId]!,
                      () {
                        setState(() {
                          selectedAccessories[q.questionId] =
                              !selectedAccessories[q.questionId]!;
                        });
                      },
                    );
                  },
                ),
              ),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedAccessories.containsValue(true)
                      ? () {
                          Get.to(() => YourDeviceScreen());
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appBlueColor3,
                    disabledBackgroundColor: ColorConstants.appBlueColor3,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAccessoryCard(
    String imagePath,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: isSelected ? Colors.blueGrey : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 80,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
