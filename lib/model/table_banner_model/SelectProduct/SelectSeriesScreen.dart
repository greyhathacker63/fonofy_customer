// screens/select_series_model_screen.dart
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/controllers/SellControllers/SellBrandBasedModelController.dart';
import 'package:get/get.dart';


class SelectSeriesModelScreen extends StatefulWidget {
  final String seriesName;

  const SelectSeriesModelScreen({super.key, required this.seriesName});

  @override
  _SelectSeriesModelScreenState createState() => _SelectSeriesModelScreenState();
}

class _SelectSeriesModelScreenState extends State<SelectSeriesModelScreen> {
  late final SellBrandBasedModelController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SellBrandBasedModelController());
    controller.fetchSeriesData(widget.seriesName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Model"),
        leading: BackButton(),
      ),
      body: Obx(() {
        if (controller.isSellBrandModelLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Series",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.series.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.0,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (_, index) {
                  final item = controller.series[index];
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade100,
                    ),
                    child: Center(
                      child: Text(
                        item.seriesName ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text("Models",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.models.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (_, index) {
                  final model = controller.models[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        model.image != null
                            ? Image.network(
                                "$imageAllBaseUrl${model.image}",
                                height: 50,
                                width: 50,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image),
                              )
                            : const Icon(Icons.image, size: 40),
                        const SizedBox(height: 5),
                        Text(
                          model.productAndModelName ?? '',
                          style: const TextStyle(fontSize: 11),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
