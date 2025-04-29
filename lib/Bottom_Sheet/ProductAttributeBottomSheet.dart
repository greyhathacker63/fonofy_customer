import 'package:flutter/material.dart';
import 'package:fonofy/model/DataObject.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductRamRomColorListModel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Api_Service/AddToCartService/AddToCartService.dart';
import '../Api_Service/ProductDetailsService/ProductRamRomColorsService.dart';
import '../Cart_Screens/CartScreen.dart';
import '../TokenHelper/TokenHelper.dart';
import '../ViewScreen/LoginScreen.dart';
import '../utils/Colors.dart';

class ProductAttributeBottomSheet extends StatefulWidget {
  final ProductDetailsModel product;
  // final Function onTap;
  const ProductAttributeBottomSheet({super.key, required this.product,});
  @override
  _ProductAttributeBottomSheetState createState() =>
      _ProductAttributeBottomSheetState();
}
class _ProductAttributeBottomSheetState

    extends State<ProductAttributeBottomSheet> {
  String selectedCondition = "Fair";
  String selectedStorage = "";
  int selectedColorIndex = 0;
  bool showDealsOnly = false;

  final _serviceProductRamRom = ProductRamRomColorsService();

  List<ProductRamRomColorListModel> _colorList = [];
  ProductRamRomColorListModel? selectedVariant;

  @override
  void initState() {
    super.initState();
    _fetchColors();
  }

  Future<void> _fetchColors() async {
    List<ProductRamRomColorListModel> colors = await _serviceProductRamRom.fetchProductRamRomListColorsData(
        widget.product.modelUrl.toString(),
        widget.product.ucode.toString());

    setState(() {
      _colorList = colors;
      selectedVariant = _colorList.firstWhere(
            (item) =>
        item.ramName == widget.product.ramName &&
            item.romName == widget.product.romName &&
            item.colorName == widget.product.colorName,
        orElse: () => _colorList.first,
      );

      selectedStorage = "${selectedVariant?.ramName ?? ''} / ${selectedVariant?.romName ?? ''}";
      selectedColorIndex = _colorList.indexOf(selectedVariant!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.productAndModelName ?? "",
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "$selectedCondition / $selectedStorage / Color ${selectedVariant?.colorName ?? widget.product.colorName}",
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text:
                  "₹${selectedVariant?.f2 ?? widget.product.sellingPrice ?? '0'} ",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                      " ₹${selectedVariant?.newAmount ?? widget.product.newModelAmt ?? '0'} ",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                    TextSpan(
                      text: "  You Save ₹ ${_calculateSavings()}",
                      style: TextStyle(fontSize: 12, color: Colors.green[700]),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _sectionTitle("Condition"),
              Wrap(
                spacing: 8,
                children: ["Fair", "Good", "Superb"].map((condition) {
                  return ChoiceChip(
                    label: Text(condition),
                    selected: selectedCondition == condition,
                    onSelected: (_) {
                      setState(() => selectedCondition = condition);
                    },
                    selectedColor: Colors.teal.shade100,
                    labelStyle: TextStyle(
                      color: selectedCondition == condition
                          ? Colors.white
                          : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              Row(
                children: [
                  Checkbox(
                    value: showDealsOnly,
                    onChanged: (val) =>
                        setState(() => showDealsOnly = val ?? false),
                  ),
                  const Text("Show deals only"),
                ],
              ),
              const SizedBox(height: 10),
              _buildWarrantyCard(),
              const SizedBox(height: 10),
              _sectionTitle("Storage"),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _colorList.length,
                itemBuilder: (context, index) {

                  String selectRom = _colorList[index].romName.toString();
                  String storage = "${_colorList[index].ramName} / ${_colorList[index].romName}";
                  bool isSelected = selectedStorage == storage;
                  // DataClass.selectedSRam = _colorList[index].ramName;
                  // DataClass.selectedSRom = _colorList[index].romName;
                  return OutlinedButton(
                    onPressed: () {
                      // widget.onTap();
                      setState(() {
                        if(selectRom =="64GB"){
                          selectedCondition = "Fair";
                        }else if(selectRom == "128GB"){
                          selectedCondition = "Good";
                        }else if(selectRom == "256GB"){
                          selectedCondition = "Superb";
                        }
                        selectedStorage = storage;
                        selectedVariant = _colorList[index];
                        selectedColorIndex = index;
                        // DataClass.sellingPrice = selectedVariant?.f2.toString();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: isSelected ? Colors.teal : Colors.grey),
                      backgroundColor: isSelected ? Colors.teal.shade50 : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          storage,
                          style: TextStyle(
                              color: isSelected ? Colors.teal : Colors.black),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.check, color: Colors.teal, size: 18)
                        ]
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              _sectionTitle("Color"),
              const SizedBox(height: 10),

              Wrap(
                spacing: 14,
                runSpacing: 12,
                children: _colorList.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;
                  bool isSelected = selectedColorIndex == index;
                  Color circleColor = getColorFromName(item.colorName ?? "Grey");

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColorIndex = index;
                        selectedVariant = _colorList[index];
                        selectedStorage = "${selectedVariant?.ramName} / ${selectedVariant?.romName}";
                      });
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: circleColor,
                              child: isSelected
                                  ? const Icon(Icons.check,
                                  color: Colors.black87, size: 16)
                                  : null,
                            ),
                            Positioned(
                              bottom: -12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                // child: Text(
                                //   "₹${item.newAmount ?? '0'}", // You can change to 'off' if needed
                                //   style: const TextStyle(fontSize: 10, color: Colors.white),
                                // ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.colorName ?? "Color",
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 10),

              // Center(
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.blue,
              //       foregroundColor: Colors.white,
              //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       minimumSize: Size(300, 50),
              //     ),
              //     // onPressed: () async {
              //     //   DataClass.productName = widget.product.productAndModelName.toString();
              //     //   final userCode = await TokenHelper.getUserCode();
              //     //   if (userCode == null) {
              //     //     Get.to(() => LoginScreen());
              //     //   } else {
              //     //     var response = await AddToCartService.fetchAddToCartData(userCode);
              //     //     if (response != null) {
              //     //       Get.to(() => CartScreen());
              //     //     } else {
              //     //       ScaffoldMessenger.of(context).showSnackBar(
              //     //         SnackBar(
              //     //           content: Text("Something went wrong! Please try again."),
              //     //           backgroundColor: Colors.redAccent,
              //     //         ),
              //     //       );
              //     //     }
              //     //   }
              //     // },
              //     onPressed: () async {
              //       // DataClass.productName = widget.product.productAndModelName.toString();
              //       final userCode = await TokenHelper.getUserCode();
              //       if (userCode == null) {
              //         Get.to(() => LoginScreen());
              //       } else {
              //         AddToCartService addToCartService = AddToCartService();
              //         // var response = await addToCartService.fetchAddToCartData(userCode);
              //         // if (response != null) {
              //         //   Get.to(() => CartScreen());
              //         // } else {
              //         //   ScaffoldMessenger.of(context).showSnackBar(
              //         //     SnackBar(
              //         //       content: Text("Something went wrong! Please try again."),
              //         //       backgroundColor: Colors.redAccent,
              //         //     ),
              //         //   );
              //         // }
              //       }
              //     },
              //     child: const Text("ADD TO CART"),
              //   ),
              // )

            ],
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String text) => Text(
    text,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );

  Widget _buildWarrantyCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.verified, color: Colors.teal),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Add ",
                      children: [
                        TextSpan(
                          text: "6 Months",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: " extended warranty at ₹899"),
                      ],
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: const Text("Add")),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "All devices have a default 6 Months warranty out of the box",
              style: TextStyle(color: Colors.teal, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  String _calculateSavings() {
    double mrp =
        double.tryParse(selectedVariant?.newAmount?.toString() ?? "0") ?? 0;
    double sp = double.tryParse(selectedVariant?.f1?.toString() ?? "0") ?? 0;
    return (mrp - sp).toStringAsFixed(0);
  }
}
