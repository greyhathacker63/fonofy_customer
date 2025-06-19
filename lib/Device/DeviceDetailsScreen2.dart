import 'package:flutter/material.dart';
import 'package:fonofy/Device/DeviceDetailsScreen3.dart';
import 'package:fonofy/controllers/DeviceQuestions/DeviceQuestionsController.dart';
import 'package:fonofy/model/SellDevice/DeviceQuestions.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class DeviceDetailScreen2 extends StatefulWidget {
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
  final List<String> secondPageAns;

  const DeviceDetailScreen2({
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
    required this.secondPageAns,
  }) : super(key: key);

  @override
  State<DeviceDetailScreen2> createState() => _DeviceDetailScreen2State();
}

class _DeviceDetailScreen2State extends State<DeviceDetailScreen2> {
  final SellQuestionController controller = Get.put(SellQuestionController());
  final Map<String, bool> selectedDefects = {};
  

  final List<String> staticImages = [
    "assets/images/broken.png",
    "assets/images/DeadSpot.png",
    "assets/images/scratch.png",
    "assets/images/DevicePanelMissing.png",
  ];

  @override
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
            (d) => d.pageId == 2,
            orElse: () => Datum(questions: []));

        final defects = pageData?.questions ?? [];

        if (defects.isEmpty) {
          return const Center(child: Text("No defect questions found."));
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select screen/body defects that are applicable!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text("Please provide correct details."),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: defects.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final question = defects[index];
                    final imagePath = staticImages.length > index
                        ? staticImages[index]
                        : staticImages[index % staticImages.length];

                    selectedDefects.putIfAbsent(
                        question.questionId ?? '', () => false);

                    return buildDefectTile(
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
                        selectedDefects.values.any((v) => v == true);

                    if (!anySelected) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Please select at least one defect.")),
                      );
                      print("Selected" + anySelected.toString());
                      return;
                    }

                    Get.to(() => DeviceDetailsScreen3(
                          baseprice: widget.baseprice,
                          bid: widget.bid,
                          raid: widget.raid,
                          roid: widget.roid,
                          modelNo: widget.modelNo,
                          ram: widget.ram,
                          rom: widget.rom,
                          modelName: widget.modelName, thirdPageAns:widget.secondPageAns,
                          
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

  Widget buildDefectTile(
      String key, String label, String imagePath, int index) {
    final isSelected = selectedDefects[key] ?? false;
    final pageData = controller.sellQuestion.value?.data
        ?.firstWhere((d) => d.pageId == 2, orElse: () => Datum(questions: []));

    final defects = pageData?.questions ?? [];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDefects[key] = !isSelected;
        });
        print("Selecteddefects" + selectedDefects.toString());
        print("b" + isSelected.toString());
        if (!isSelected) {
          // On selecting a defect (i.e., was unselected before, now selected)
          final selectedOptions = defects[index].options;

          for (var opt in selectedOptions!) {
            final weight = opt.weightage?.toString() ?? '1.0';
            widget.secondPageAns.add(weight);
          }

          print("Collected secondPageAns: ${widget.secondPageAns}");
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
            Image.asset(imagePath, height: 80, width: 70),
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
