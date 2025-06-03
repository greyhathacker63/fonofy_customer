import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/RepairService/RepairServiceScreen.dart';
import 'package:fonofy/controllers/RepairController/ColorRepairController.dart';

import '../RepairScreen/SelectRepairServices.dart';
import '../utils/Colors.dart';

class SelectColorsProductScreen extends StatefulWidget {
  final String brandId;
  final String modelId;

  const SelectColorsProductScreen({
    super.key,
    required this.brandId,
    required this.modelId,
  });

  @override
  State<SelectColorsProductScreen> createState() =>
      _SelectColorsProductScreenState();
}

class _SelectColorsProductScreenState extends State<SelectColorsProductScreen> {
  final RepairColorsController repairColorController = Get.put(RepairColorsController());
String getAssetImagePath = 'assets/images/Repair_phone.png';
  @override
  void initState() {
    super.initState();
// Defer API call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(
          'Fetching colors for brandId: ${widget.brandId}, modelId: ${widget.modelId}');
      repairColorController.getRepairColorsData(widget.brandId,widget.modelId );

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Color"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
             },
          ),
        ],
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: repairColorController.isRepairColorsLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.blue,
                        ),
                      )
                    : repairColorController.colorListRepair.isEmpty
                        ? Center(
                            child: Text(""))
                        : GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: repairColorController.colorListRepair.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, index) {
                              final colorDetails = repairColorController.colorListRepair[index];
                              return GestureDetector(
                                onTap: () {
                                  final colorData =
                                  print('Selected color: ${colorDetails.colorName}, ID: ${colorDetails.colorId}');
                                  // Get.to(() => RepairServiceScreen());
                                  Get.to(() => SelectServicesScreen(brandId: colorDetails.brand ?? '', productId: colorDetails.modelNo ?? '', colorId: colorDetails.colorId.toString(),));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Container(
                                        width: 60,
                                          height: 60,
                                          child: Image.asset("assets/images/Repair_phone.png")),

                                  //     colorDetails.colorImage != null && colorDetails
                                  //                 .colorImage!.isNotEmpty
                                  //         ? Image.asset(
                                  //             // "$imageAllBaseUrl${colorDetails.colorImage}",
                                  //       'assets/images/Repair_phone.png',
                                  //   height: 50,
                                  //   width: 50,
                                  //    fit: BoxFit.cover,
                                  //    errorBuilder: (context, error, stackTrace) =>   SizedBox(
                                  //    height: 50,
                                  //    width: 50,
                                  //    child: Icon(
                                  //     Icons.error,
                                  //     color: Colors.red,
                                  //     size: 40,
                                  //   ),
                                  // ),
                                  //     )
                                  //         : SizedBox(
                                  //             height: 50,
                                  //             width: 50,
                                  //             child: Container(
                                  //               decoration: BoxDecoration(
                                  //                 shape: BoxShape.circle,
                                  //                 // color: getColorFromName(colorDetails.colorName.toString()),
                                  //               ),
                                  //             ),
                                  //           ),
                                       SizedBox(height: 10),
                                      Text(
                                        colorDetails.colorName ?? '',
                                        style: const TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),
          )),
    );
  }
}
