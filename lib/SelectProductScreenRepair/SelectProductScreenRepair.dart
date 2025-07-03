
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/SelectProductScreenRepair/selectColorsProductScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../controllers/RepairController/RepairBrandBasedModelController.dart';
import '../utils/Colors.dart';


class SelectProductRepairScreen extends StatelessWidget {
  final String brandName;
  final String placeholderImage = "assets/images/phone.png";

  SelectProductRepairScreen({super.key, required this.brandName});

  final RepairBrandBasedModelController brandBasedRepairController = Get.put(RepairBrandBasedModelController());


  @override
  Widget build(BuildContext context) {
    brandBasedRepairController.getRepairBrandModelsData(brandName);

    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.white,
        title: Text("Select $brandName Model"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   IconButton(
        //     icon:  Icon(Icons.search),
        //     onPressed: () {
        //       // Implement search functionality if needed
        //     },
        //   ),
        // ],
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
            child: brandBasedRepairController.isRepairBrandModelLoading.value
                ?   Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue,
              ),
            )
                : brandBasedRepairController.brandList.isEmpty
                ? Center(child: Text("No models available for $brandName"))
                : GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: brandBasedRepairController.brandList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8, // Adjusted to make cells taller
              ),
              itemBuilder: (context, index) {
                final brandBasedModelDetails = brandBasedRepairController.brandList[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => SelectColorsProductScreen(
                      brandId: brandBasedModelDetails.brandId.toString(),
                      modelId: brandBasedModelDetails.productId.toString(),));
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        brandBasedModelDetails.image != null && brandBasedModelDetails.image!.isNotEmpty
                            ? Image.network("$imageAllBaseUrl${brandBasedModelDetails.image}",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.image,
                              color: ColorConstants.appBlueColor3,
                              size: 40,
                            ),
                          ),
                        )
                            : SizedBox(
                          height: 50,
                          width: 50,
                          child: Icon(
                            Icons.image,
                            color:ColorConstants.appBlueColor3,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          brandBasedModelDetails.productAndModelName ?? 'Unknown Model',
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
