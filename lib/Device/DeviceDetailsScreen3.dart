import 'package:flutter/material.dart';
import 'package:fonofy/Device/DeviceDetailsScreen4.dart';
import 'package:fonofy/controllers/DeviceQuestions/DeviceQuestionsController.dart';
import 'package:fonofy/model/SellDevice/DeviceQuestions.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class DeviceDetailsScreen3 extends StatefulWidget {
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
  final List<String> thirdPageAns;


  const DeviceDetailsScreen3({
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
    required this.thirdPageAns,
  }) : super(key: key);

  @override
  State<DeviceDetailsScreen3> createState() => _DeviceDetailsScreen3State();
}

class _DeviceDetailsScreen3State extends State<DeviceDetailsScreen3> {
  final SellQuestionController controller = Get.put(SellQuestionController());
  final Map<String, bool> selectedIssues = {};

  final List<String> staticImages = [
    "assets/images/front.png",
    "assets/images/back.png",
    "assets/images/volume.png",
    "assets/images/finger.png",
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
    return Scaffold(backgroundColor: Colors.white,
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
            (d) => d.pageId == 3,
            orElse: () => Datum(questions: []));

        final issues = pageData?.questions ?? [];

        if (issues.isEmpty) {
          return const Center(child: Text("No issue questions found."));
        }

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
                child: GridView.builder(
                  itemCount: issues.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final question = issues[index];
                    final imagePath = staticImages.length > index
                        ? staticImages[index]
                        : staticImages[index % staticImages.length];

                    selectedIssues.putIfAbsent(
                        question.questionId ?? '', () => false);

                    return buildIssueTile(
                      question.questionId ?? '',
                      question.question ?? '',
                      imagePath,
                      index,
                    );
                  },
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
                    final anySelected =
                        selectedIssues.values.any((v) => v == true);

                    if (!anySelected) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please select at least one issue.")),
                      );
                      return;
                    }

                    Get.to(() => DeviceDetailsScreen4(
                          pid: widget.pid,
                          bid: widget.bid,
                          baseprice: widget.baseprice,
                          raid: widget.raid,
                          roid: widget.roid,
                          selectedVariant: widget.selectedVariant,
                          modelNo: widget.modelNo,
                          ram: widget.ram,
                          rom: widget.rom,
                          modelName: widget.modelName, fourthPageAns: widget.thirdPageAns,
                        ));
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
        );
      }),
    );
  }

  Widget buildIssueTile(String key, String label, String imagePath, int index) {
    final isSelected = selectedIssues[key] ?? false;
    final pageData = controller.sellQuestion.value?.data
        ?.firstWhere((d) => d.pageId ==3, orElse: () => Datum(questions: []));

    final issues = pageData?.questions ?? [];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIssues[key] = !isSelected;
        });
        print("Selecteddefects" + selectedIssues.toString());
        print("b" + isSelected.toString());
        if (!isSelected) {
          // On selecting a defect (i.e., was unselected before, now selected)
          final selectedOptions = issues[index].options;

          for (var opt in selectedOptions!) {
            final weight = opt.weightage?.toString() ?? '1.0';
            widget.thirdPageAns.add(weight);
          }

          print("Collected thirdPageAns: ${widget.thirdPageAns}");
        }
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
                style:
                    TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
