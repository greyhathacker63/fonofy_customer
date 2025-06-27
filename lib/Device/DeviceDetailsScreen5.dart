import 'package:flutter/material.dart';
import 'package:fonofy/YourDevice/YourDevice.dart';
import 'package:fonofy/controllers/DeviceQuestions/DeviceQuestionsController.dart';
import 'package:fonofy/model/SellDevice/DeviceQuestions.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class DeviceDetailsScreen5 extends StatefulWidget {
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
  //final List<String> fivePageAns;

  const DeviceDetailsScreen5({
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
    //required this.fivePageAns,
  }) : super(key: key);

  @override
  State<DeviceDetailsScreen5> createState() => _DeviceDetailsScreen5State();
}

class _DeviceDetailsScreen5State extends State<DeviceDetailsScreen5> {
  final SellQuestionController controller = Get.put(SellQuestionController());
  final Map<String, bool> selectedAccessories = {};
  final Map<String, String> radioSelections = {}; // questionId -> "Yes" / "No"
  final List<String> fivePageAns = [];
  var pageNumber = "0".obs;
  var totalPages = "0".obs;

  final List<String> staticImages = [
    "assets/images/charger.png",
    "assets/images/boximei.png",
    "assets/images/earphones.png",
    "assets/images/cable.png",
    "assets/images/default1.png",
    "assets/images/default2.png",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isLoading = true.obs;
      callApiForGettingQUestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
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
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    controller.mQuestionListData
                            ?.data?[int.parse(pageNumber.value)].pageTitle ??
                        "",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    controller
                            .mQuestionListData
                            ?.data?[int.parse(pageNumber.value)]
                            .pageDescription ??
                        "",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: controller
                              .mQuestionListData!
                              .data![int.parse(pageNumber.value)]
                              .questions!
                              .first
                              .questionSelection
                              .toString() ==
                          "Radio Button(Yes/No)"
                      ? _buildRadioButton(
                          radioButtonDetails: controller.mQuestionListData
                              ?.data?[int.parse(pageNumber.value)])
                      : GridView.builder(
                          itemCount: controller
                                  .mQuestionListData
                                  ?.data?[int.parse(pageNumber.value)]
                                  .questions
                                  ?.length ??
                              0,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.9,
                          ),
                          itemBuilder: (context, index) {
                            final q = controller
                                .mQuestionListData
                                ?.data?[int.parse(pageNumber.value)]
                                .questions?[index];
                            final qId = q?.questionId ?? '';
                            final qText = q?.question ?? '';

                            if (qId.isEmpty) return const SizedBox();

                            final imagePath = index < staticImages.length
                                ? staticImages[index]
                                : "assets/images/default.png";
                            selectedAccessories.putIfAbsent(qId, () => false);

                            // ✅ Return the widget properly

                            return _buildAccessoryCard(
                                qId, qText, imagePath, index);
                          },
                        ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print(
                          "Page: ${pageNumber.value} / Total: ${totalPages.value}");
                      if (totalPages.value != "0") {
                        if (int.parse(pageNumber.value) ==
                            int.parse(totalPages.value) - 1) {
                          print("All questions submitted");

                          // Navigate to YourDeviceScreen with all required values
                          Get.to(() => YourDeviceScreen(
                                baseprice: widget.baseprice,
                                bid: widget.bid,
                                raid: widget.raid,
                                roid: widget.roid,
                                modelNo: widget.modelNo,
                                ram: widget.ram,
                                rom: widget.rom,
                                modelName: widget.modelName,
                                finalhPageAns: fivePageAns,
                              ));
                        } else {
                          // Go to next page
                          pageNumber.value =
                              (int.parse(pageNumber.value) + 1).toString();
                        }
                      }
                    },
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
        }
      }),
    );
  }

  // Widget _buildRadioButton(
  //     // String questionId,
  //     // String title,
  //     // String description,
  //     // String? selectedValue,

  //     {Datum? radioButtonDetails}
  //     // Function(String?) onChanged,
  //     ) {
  //   return ListView.builder(
  //     itemCount: radioButtonDetails?.questions?.length ?? 0,
  //     itemBuilder: (context, index) {
  //       final redioButtonQuestionData = radioButtonDetails?.questions?[index];
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             redioButtonQuestionData?.question ?? "",
  //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 5),
  //           Text(
  //             redioButtonQuestionData?.questionDescription ?? "",
  //             style: const TextStyle(fontSize: 14, color: Colors.grey),
  //           ),
  //           const SizedBox(height: 10),

  //           Row(children: [
  //             Expanded(
  //               child: GestureDetector(
  //                 onTap: () {
  //                   final yesOptionStore =
  //                       redioButtonQuestionData!.options!.firstWhere(
  //                     (element) => element.amount == 100,
  //                     // Provide an orElse callback to handle cases where no match is found
  //                     // (though .any() already confirms one exists here)
  //                   );
  //                   print("object");
  //                   print(yesOptionStore.weightage);
  //                 },
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.check_box_rounded),
  //                     SizedBox(width: 10),
  //                     Text('Yes')
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: GestureDetector(
  //                 onTap: () {
  //                   final noOptionStore =
  //                       redioButtonQuestionData!.options!.firstWhere(
  //                     (element) => element.amount != 100,
  //                     // Provide an orElse callback to handle cases where no match is found
  //                     // (though .any() already confirms one exists here)
  //                   );
  //                   print("object");
  //                   print(noOptionStore.weightage);
  //                 },
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.check_box_rounded),
  //                     SizedBox(width: 10),
  //                     Text('No')
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ]),

  //           // ),

  //           // Row(
  //           //   children: [
  //           //     Expanded(
  //           //       child: RadioListTile<String>(
  //           //         title: const Text("Yes"),
  //           //         value: "Yes",
  //           //         groupValue: selectedValue,
  //           //         onChanged: onChanged,
  //           //       ),
  //           //     ),
  //           //     Expanded(
  //           //       child: RadioListTile<String>(
  //           //         title: const Text("No"),
  //           //         value: "No",
  //           //         groupValue: selectedValue,
  //           //         onChanged: onChanged,
  //           //       ),
  //           //     ),
  //           //   ],
  //           // ),
  //           const SizedBox(height: 10),
  //         ],
  //       );
  //     },
  //   );
  // }
  Widget _buildRadioButton({Datum? radioButtonDetails}) {
  return ListView.builder(
    itemCount: radioButtonDetails?.questions?.length ?? 0,
    itemBuilder: (context, index) {
      final question = radioButtonDetails!.questions![index];
      final questionId = question.questionId ?? '';

      final selectedValue = radioSelections[questionId];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question ?? "",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            question.questionDescription ?? "",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      radioSelections[questionId] = "Yes";
                      final yesOption = question.options!
                          .firstWhere((opt) => opt.amount == 100);
                      fivePageAns.add(yesOption.weightage?.toString() ?? '0');
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        radioSelections[questionId] == "Yes"
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      const Text("Yes"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      radioSelections[questionId] = "No";
                      final noOption = question.options!
                          .firstWhere((opt) => opt.amount != 100);
                      fivePageAns.add(noOption.weightage?.toString() ?? '0');
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        radioSelections[questionId] == "No"
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      const Text("No"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      );
    },
  );
}


  Widget _buildAccessoryCard(
      String key, String label, String imagePath, int index) {
    final isSelected = selectedAccessories[key] ?? false;
    //final pageData = controller.sellQuestion.value?.data
    //   ?.firstWhere((d) => d.pageId == 4, orElse: () => Datum(questions: []));

    final pageData =
        controller.mQuestionListData?.data?[int.parse(pageNumber.value)];
    final issues = pageData?.questions ?? [];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAccessories[key] = !isSelected;
        });
        if (!isSelected) {
          // On selecting a defect (i.e., was unselected before, now selected)
          final selectedOptions = issues[index].options;

          for (var opt in selectedOptions!) {
            final weight = opt.weightage?.toString() ?? '1.0';
            fivePageAns.add(weight);
          }

          print("Collected finalhPageAns: ${fivePageAns}");
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

  Future<void> callApiForGettingQUestion() async {
    await controller.loadSellQuestions(
      bid: int.parse(widget.bid),
      pid: int.tryParse(widget.pid ?? "0"),
      raid: int.parse(widget.raid),
      roid: int.parse(widget.roid),
      model: widget.modelNo,
      ram: widget.ram,
      rom: widget.rom,
      basePrice: widget.baseprice,
    );

    totalPages.value =
        controller.mQuestionListData?.totalPageNumber.toString() ?? "0";
  }
}
