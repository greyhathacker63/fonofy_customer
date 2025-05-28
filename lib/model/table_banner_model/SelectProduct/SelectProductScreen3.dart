import 'package:flutter/material.dart';
import 'package:fonofy/model/table_banner_model/SelectProduct/SelectProductScreen.dart';
import 'package:get/get.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../../../controllers/SellControllers/SellBrandBasedModelController.dart';
import '../../../utils/Colors.dart';

class SelectProductScreen3 extends StatelessWidget {
  final String brandName;

  SelectProductScreen3({super.key, required this.brandName});

  final List<String> seriesList = [
    'V Series',
    'X Series',
    'Y Series',
    'Nex Series',
    'Z Series',
    'S Series',
    'U Series',
    'T Series',
  ];

  final SellBrandBasedModelController sellBrandBasedModelController = Get.put(SellBrandBasedModelController());

  @override
  Widget build(BuildContext context) {
    sellBrandBasedModelController.getSellBrandModelsData(brandName);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Select $brandName Model", style: const TextStyle(fontSize: 18)),
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
              // Implement search functionality here if needed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:   EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            elevation: 3,
            child: Padding(
              padding:   EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding:   EdgeInsets.only(right: 180),
                    child: Text("Select Series",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: seriesList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 2.0,
                      ),
                      itemBuilder: (context, index) {
                        final item = seriesList[index];
                        return GestureDetector(
                          onTap: () {
                            // Optionally handle tap if you want filtering in future
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(color: Colors.grey.shade300, width: 1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(item,
                              style:  TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Models GridView
                  Obx(() => sellBrandBasedModelController.isSellBrandModelLoading.value
                      ?   Center(child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.blue,
                    ),
                  )
                      : sellBrandBasedModelController.brandList.isEmpty
                      ? Center(child: Text("No models available for $brandName"))
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sellBrandBasedModelController.brandList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final model = sellBrandBasedModelController.brandList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => SelectProductScreen(modelno: model.productAndModelName ?? ''));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              model.image != null && model.image!.isNotEmpty
                                  ? Image.network(
                                "$imageAllBaseUrl${model.image}",
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Icon(
                                  Icons.image,
                                  size: 40,
                                  color: ColorConstants.appBlueColor3,
                                ),
                              )
                                  : Icon(
                                Icons.image,
                                size: 40,
                                color: ColorConstants.appBlueColor3,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                model.productAndModelName ?? ' ',
                                style: const TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
