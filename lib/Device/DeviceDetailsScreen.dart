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
    required this.baseprice,
    required this.modelName,
  });

  @override
  State<DeviceDetailsScreen> createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {

  final SellQuestionController controller = Get.put(SellQuestionController());
  final Map<String, String?> answers = {};
  final List<String> firstPageAns = [];
  bool showSecondScreen = false;
  bool showThirdScreen = false;
  bool showFourthScreen = false;
  final Map<String, bool> selectedDefects = {};
  final Map<String, bool> selectedIssues = {};
  final List<String> staticImages = [
    "assets/images/broken.png",
    "assets/images/DeadSpot.png",
    "assets/images/scratch.png",
    "assets/images/DevicePanelMissing.png",
  ];

  final List<String> staticImagess = [
    "assets/images/front.png",
    "assets/images/back.png",
    "assets/images/volume.png",
    "assets/images/finger.png",
  ];
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
    final pageData = controller.sellQuestion.value?.data?.firstWhere(
            (d) => d.pageId == 2,
        orElse: () => Datum(questions: []));

    final defects = pageData?.questions ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Details Page"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty) {return Center(child: Text(controller.errorMessage.value));}

        final pageData = controller.sellQuestion.value?.data?.firstWhere(
            (d) => d.pageId == 1,
            orElse: () => Datum(questions: []));

        final questions = pageData?.questions ?? [];

        if (questions.isEmpty) {
          return Center(child: Text("No questions found for this page."));
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(9.0),
              child:showSecondScreen==false? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  Text("Tell us more about your device?",
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  Text(pageData?.pageTitle ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                    SizedBox(height: 5),
                   // Text("Please answer a few questions about your device.", style: TextStyle(fontSize: 14, color: Colors.grey),),
                   Text(pageData?.pageDescription ?? '', style: TextStyle(fontSize: 14, color: Colors.grey),),
                  SizedBox(height: 10),
                  // ...questions.map(
                  //   (q) => _buildQuestion(
                  //     q.questionId ?? '',
                  //     q.question ?? '',
                  //     q.questionDescription ?? '',
                  //     answers[q.questionId] ?? '',
                  //     (value) {
                  //       setState(() {
                  //         answers[q.questionId ?? ''] = value;
                  //         firstPageAns.add(q.options.first.weightage)

                  //       });
                  //       print("value" + value.toString());
                  //     },
                  //   ),
                  // ),
                  ...questions.map(
                    (q) => _buildQuestion(
                      q.questionId ?? '',
                      q.question ?? '',
                      q.questionDescription ?? '',
                      answers[q.questionId] ?? '',
                      (value) {
                        setState(() {
                          answers[q.questionId ?? ''] = value;
                          print('Selected value: $value');
                          print('Available options: ${q.options?.map((o) => o.listOptionAns)}');
                          final matchedOptions = q.options?.where(
                            (o) => o.listOptionAns?.toLowerCase() == value.toString().toLowerCase(),
                          );
                          print('Matched options: $matchedOptions');
                          final weights = matchedOptions?.map((o) => (o.weightage ?? 5.0).toString());
                          print('Weights: $weights');
                          if (weights != null) {
                            firstPageAns.addAll(weights);
                          }
                          print("Collected weights: $firstPageAns");
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
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
                          setState(() {
                            showSecondScreen=true;
                          });
                          // Get.to(() => DeviceDetailScreen2(
                          //     baseprice: widget.baseprice,
                          //     bid: widget.bid,
                          //     raid: widget.raid,
                          //     roid: widget.roid,
                          //     modelNo: widget.modelNo,
                          //     ram: widget.ram,
                          //     rom: widget.rom,
                          //     modelName: widget.modelName, secondPageAns:firstPageAns,
                          // )
                          // );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                              content: Text("Please answer all questions."),
                            ),
                          );
                        }
                      },
                      child:Text("Continue",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              ):showThirdScreen==false?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select screen/body defects that are applicable!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text("Please provide correct details."),
                  const SizedBox(height: 16),
                  Container(
                    child: GridView.builder(
                      shrinkWrap: true,
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

                        selectedDefects.putIfAbsent(question.questionId ?? '', () => false);

                        return _buildDefectTile(
                          question.questionId ?? '',
                          question.question ?? '',
                          imagePath,
                          index,
                          defects,
                        );
                      },
                    ),
                  ),
                  _buildContinueButton(defects),
                ],
              ):Column(

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
        Text(title,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          description,
          style:TextStyle(fontSize: 14, color: Colors.grey),
        ),
         SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text("Yes"),
                value: "Yes", groupValue: selectedValue,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text("No"),
                value: "No",
                groupValue: selectedValue,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
          SizedBox(height: 10),
      ],
    );
  }
  List<Question> _getDefectQuestions() {
    final pageData = controller.sellQuestion.value?.data?.firstWhere(
          (d) => d.pageId == 2,
      orElse: () => Datum(questions: []),
    );
    return pageData?.questions ?? [];
  }

  Widget _buildDefectSelection(List<Question> defects) {
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

                selectedDefects.putIfAbsent(question.questionId ?? '', () => false);

                return _buildDefectTile(
                  question.questionId ?? '',
                  question.question ?? '',
                  imagePath,
                  index,
                  defects,
                );
              },
            ),
          ),
          _buildContinueButton(defects),
        ],
      ),
    );
  }

  Widget _buildDefectTile(
      String key,
      String label,
      String imagePath,
      int index,
      List<Question> defects,
      ) {
    final isSelected = selectedDefects[key] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDefects[key] = !isSelected;
        });

        if (!isSelected) {
          final selectedOptions = defects[index].options;
          for (var opt in selectedOptions!) {
            final weight = opt.weightage?.toString() ?? '1.0';
            // widget.secondPageAns.add(weight);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? ColorConstants.appBlueColor3 : Colors.grey,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 60, width: 70),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              color:
              isSelected ? ColorConstants.appBlueColor3 : Colors.grey[300],
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(List<Question> defects) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.appBlueColor3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () {
          final anySelected = selectedDefects.values.any((v) => v == true);
          if (!anySelected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please select at least one defect."),
              ),
            );
            return;
          }

        },
        child: const Text(
          "Continue",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }


  List<Question> _getIssueQuestions() {
    final pageData = controller.sellQuestion.value?.data
        ?.firstWhere((d) => d.pageId == 3, orElse: () => Datum(questions: []));
    return pageData?.questions ?? [];
  }

  /// Method: Builds the grid UI for issues
  Widget _buildIssueGrid(List<Question> issues) {
    return Expanded(
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
          final imagePath = staticImagess.length > index
              ? staticImagess[index]
              : staticImagess[index % staticImagess.length];

          selectedIssues.putIfAbsent(question.questionId ?? '', () => false);

          return _buildIssueTile(
            question.questionId ?? '',
            question.question ?? '',
            imagePath,
            index,
            issues,
          );
        },
      ),
    );
  }

  /// Method: Builds individual issue tile
  Widget _buildIssueTile(
      String key,
      String label,
      String imagePath,
      int index,
      List<Question> issues,
      ) {
    final isSelected = selectedIssues[key] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIssues[key] = !isSelected;
        });

        if (!isSelected) {
          final selectedOptions = issues[index].options ?? [];
          for (var opt in selectedOptions) {
            final weight = opt.weightage?.toString() ?? '1.0';
            // widget.thirdPageAns.add(weight);
          }
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
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Method: Builds continue button
  Widget _buildThirdContinueButton(List<Question> issues) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.appBlueColor3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () {
          final anySelected = selectedIssues.values.any((v) => v == true);

          if (!anySelected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please select at least one issue."),
              ),
            );
            return;
          }

        },
        child: const Text(
          "Continue",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

}
