import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/model/table_banner_model/SelectProduct/SelectProduct2.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

import '../../../controllers/SellControllers/SellVariantTableControllers.dart';

class SelectProductScreen extends StatefulWidget {
  final String modelno;

  const SelectProductScreen({super.key, required this.modelno});

  @override
  _SelectProductScreenState createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  String? selectedVariant;

  SellVariantControllerTable sellVariantController =
      Get.put(SellVariantControllerTable());

  @override
  void initState() {
    super.initState();
    sellVariantController.getTableVariantData(widget.modelno);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Product"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx(() => sellVariantController.isVariantTableLoading.value
          ?   Center(child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,))
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductCard(),
                      SizedBox(height: 18),
                      Text("Choose a variant",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 15),

                    _buildVariantList(),

                      SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "The price stated above depends on the condition of the product and is not final. "
                        "The final price offer will be quoted at the end of the diagnosis.",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                      SizedBox(height: 10),
                      Text("FAQs", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Divider(),
                    faqItem("How did you calculate my device price?"),
                    faqItem("Is it safe to sell my phone on Fonofy?"),
                    faqItem("How does Voucher Payment work?"),
                      SizedBox(height: 1),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Load More FAQs",style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (selectedVariant != null) {
                final table1 = sellVariantController.tableVariantData?.table;
                final modelName = table1 != null && table1.isNotEmpty
                    ? (table1.first.modelNo.isNotEmpty == true
                        ? table1.first.modelNo : widget.modelno) : widget.modelno;
                // final image = table1 != null && table1.isNotEmpty && table1.first.image != null
                //     ? table1.first.image!
                //     : null;
                final variantParts = selectedVariant!.split(' / ');
                final ram = variantParts.isNotEmpty ? variantParts[0].trim() : ' ';
                final rom = variantParts.length > 1 ? variantParts[1].trim() : ' ';

                Get.to(() => SelectProduct2(selectedVariant: selectedVariant!, modelNo: widget.modelno, ram: ram, rom: rom,));

              } else {
                Get.snackbar(
                  'Select', 'Please select a variant.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.appBlueColor3,
              foregroundColor: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(
              "Get Exact Value",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    final table1 = sellVariantController.tableVariantData?.table1;
    if (table1 == null || table1.isEmpty) {
      return Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text("No product data available"),
        ),
      );
    }

    final product = table1.first;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            product.image != null && product.image.isNotEmpty
                ? Image.network(
                    '$imageAllBaseUrl${product.image}',
                    height: 55,
                    width: 55,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.blue,
                        )),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      "assets/images/phone.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    "assets/images/phone.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.modelName.isNotEmpty == true
                        ? product.modelName!
                        : "Unknown Product",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  // const Text(
                  //   "7400+ already sold on Fonofy",
                  //   style: TextStyle(fontSize: 12, color: Colors.green),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVariantList() {
    final variants = sellVariantController.tableVariantData?.table;
    if (variants == null || variants.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("No variants available for this model"),
      );
    }

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: variants.length,
        itemBuilder: (context, index) {
          final variant = variants[index];
          final variantString = "${variant.ramName} / ${variant.romName}";
          final isSelected = selectedVariant == variantString;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedVariant = variantString;
              });
            },
            child: Container(
              width: 170,
              margin: EdgeInsets.symmetric(horizontal: 2),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.shade100 : Colors.white,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Radio<String>(
                    value: variantString,
                    groupValue: selectedVariant,
                    onChanged: (value) {
                      setState(() {
                        selectedVariant = value!;
                      });
                    },
                  ),
                  Flexible(
                    child: Text(
                      variantString,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget faqItem(String question) {
    return Column(
      children: [
        ListTile(
          title: Text(question, style: TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.keyboard_arrow_down),
        ),
        const Divider(),
      ],
    );
  }
}
