import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/model/table_banner_model/SelectProduct/SelectProductScreen.dart';

class SelectColorsProductScreen extends StatelessWidget {
  final String brandName;
  final String modelId;

  // final String placeholderImage = "assets/images/phone.png";

  SelectColorsProductScreen({
    super.key,
    required this.brandName,
    required this.modelId,
  });

  final ColorBasedModelController colorController = Get.put(ColorBasedModelController());

  @override
  Widget build(BuildContext context) {
    colorController.getColorData(modelId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Select $brandName Color"),
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
              // Implement search functionality if needed
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
            child: colorController.isColorLoading.value
                ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue,
              ),
            )
                : colorController.colorList.isEmpty
                ? Center(child: Text("No colors available for $brandName"))
                : GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: colorController.colorList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final colorDetails = colorController.colorList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => SelectProductScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colorDetails.colorImage != null && colorDetails.colorImage!.isNotEmpty
                            ? Image.network(
                          "$imageAllBaseUrl${colorDetails.colorImage}",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        )
                            : SizedBox(
                          height: 50,
                          width: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _parseColor(colorDetails.colorName),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          colorDetails.colorName ?? 'U',
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

  // Parse color name to Color (basic mapping for common colors)
  Color _parseColor(String? colorName) {
    if (colorName == null) return Colors.grey;
    switch (colorName.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}

class ColorBasedModel {
  dynamic colorId;
  String? colorName;
  String? colorImage;

  ColorBasedModel({
    this.colorId,
    this.colorName,
    this.colorImage,
  });

  factory ColorBasedModel.fromJson(Map<String, dynamic> json) => ColorBasedModel(
    colorId: json["colorId"],
    colorName: json["colorName"],
    colorImage: json["colorImage"],
  );

  Map<String, dynamic> toJson() => {
    "colorId": colorId,
    "colorName": colorName,
    "colorImage": colorImage,
  };
}

class ColorBasedModelController extends GetxController {
  var isColorLoading = true.obs;
  List<ColorBasedModel> _colorList = [];

  List<ColorBasedModel> get colorList => _colorList;

  Future<void> getColorData(String modelId) async {
    isColorLoading.value = true;
    try {
      _colorList = await ColorBasedModelService.fetchColorsByModel(modelId);
      print('Fetched colors for model $modelId: ${_colorList.map((c) => c.colorName).toList()}');
    } catch (err) {
      print('Color Error: $err');
      Get.snackbar("Error", "Failed to load colors: $err", backgroundColor: Colors.redAccent);
    } finally {
      isColorLoading.value = false;
      update();
    }
  }
}

// Placeholder service (replace with actual implementation)
class ColorBasedModelService {
  static Future<List<ColorBasedModel>> fetchColorsByModel(String modelId) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    // Replace with actual API call
    return [
      ColorBasedModel(colorId: 1, colorName: "Black", colorImage: "black.jpg"),
      ColorBasedModel(colorId: 2, colorName: "Blue", colorImage: "blue.jpg"),
      ColorBasedModel(colorId: 3, colorName: "Red"),
    ];
  }
}