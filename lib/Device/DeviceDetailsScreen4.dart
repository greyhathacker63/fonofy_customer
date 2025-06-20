import 'package:flutter/material.dart';
import 'package:fonofy/Device/DeviceDetailsScreen5.dart';
import 'package:fonofy/controllers/DeviceQuestions/DeviceQuestionsController.dart';
import 'package:fonofy/model/SellDevice/DeviceQuestions.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class DeviceDetailsScreen4 extends StatefulWidget {
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
  final List<String> fourthPageAns;

  const DeviceDetailsScreen4({
    Key? key,
    this.pid,
    required this.bid,
    required this.baseprice,
    required this.raid,
    required this.roid,
    this.selectedVariant,
    required this.modelNo,
    required this.ram,
    required this.rom,
    required this.modelName,
    required this.fourthPageAns,
  }) : super(key: key);

  @override
  State<DeviceDetailsScreen4> createState() => _DeviceDetailsScreen4State();
}

class _DeviceDetailsScreen4State extends State<DeviceDetailsScreen4> {
  final SellQuestionController controller = Get.put(SellQuestionController());
  final Map<String, bool> selectedAccessories = {};

  final List<String> staticImages = [
    "assets/images/charger.png",
    "assets/images/boximei.png",
    "assets/images/earphones.png",
    "assets/images/cable.png",
    "assets/images/default1.png",
    "assets/images/default2.png",
  ];

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    });
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

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final pageData = controller.sellQuestion.value?.data?.firstWhere(
            (d) => d.pageId == 4,
            orElse: () => Datum(questions: []));

        final questions = pageData?.questions ?? [];

        if (questions.isEmpty) {
          return const Center(child: Text("No accessory questions found."));
        }

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
                    final qId = q.questionId ?? '';
                    final qText = q.question ?? '';

                    if (qId.isEmpty)
                      return const SizedBox(); // skip invalid entries

                    final imagePath = index < staticImages.length
                        ? staticImages[index]
                        : "assets/images/default.png";

                    selectedAccessories.putIfAbsent(qId, () => false);

                    // ✅ Return the widget properly
                    return _buildAccessoryCard(qId, qText, imagePath, index);
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedAccessories.containsValue(true)
                      ? () {
                          Get.to(() => DeviceDetailsScreen5(

                                baseprice: widget.baseprice,
                                bid: widget.bid,
                                raid: widget.raid,
                                roid: widget.roid,
                                modelNo: widget.modelNo,
                                ram: widget.ram,
                                rom: widget.rom,
                                modelName: widget.modelName, fivePageAns: widget.fourthPageAns,
                              ));
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
      String key, String label, String imagePath, int index) {
    final isSelected = selectedAccessories[key] ?? false;
    final pageData = controller.sellQuestion.value?.data
        ?.firstWhere((d) => d.pageId == 4, orElse: () => Datum(questions: []));

    final issues = pageData?.questions ?? [];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAccessories[key] = !isSelected;
        });
        print("Selecteddefects" + selectedAccessories.toString());
        print("b" + isSelected.toString());
        if (!isSelected) {
          // On selecting a defect (i.e., was unselected before, now selected)
          final selectedOptions = issues[index].options;

          for (var opt in selectedOptions!) {
            final weight = opt.weightage?.toString() ?? '1.0';
            widget.fourthPageAns.add(weight);
          }

          print("Collected fourthPageAns: ${widget.fourthPageAns}");
        }
      },
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
