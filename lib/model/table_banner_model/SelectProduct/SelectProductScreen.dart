import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/model/table_banner_model/SelectProduct/SelectProduct2.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

//
// class SelectProductScreen extends StatefulWidget {
//
//   @override
//   _SelectProductScreenState createState() => _SelectProductScreenState();
// }
//
// class _SelectProductScreenState extends State<SelectProductScreen> {
//   String? selectedVariant;
//
//   final List<String> variants = ["4 GB / 64 GB", "16 GB / 64 GB", "8 GB / 128 GB"];
//   final String imagePath = "assets/images/phone.png";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Product"),
//         leading: const Icon(Icons.arrow_back),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Row(
//                   children: [
//                     Image.asset(imagePath, height: 50, width: 50, fit: BoxFit.cover),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                             Text("Apple iPhone 6 Plus",
//                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                             SizedBox(height: 5),
//                             Text("7400+ already sold on Fonofy",
//                             style: TextStyle(fontSize: 12, color: Colors.green),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//               SizedBox(height: 18),
//               Text("Choose a variant", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               SizedBox(height: 15),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: variants.map((variant) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedVariant = variant;
//                       });
//                     },
//                     child: Container(
//                        width: 165,
//                       margin:   EdgeInsets.symmetric(horizontal: 3), // spacing between items
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(8),
//                         color: selectedVariant == variant ? Colors.blue.shade100 : Colors.white,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Radio<String>(
//                             value: variant,
//                             groupValue: selectedVariant,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedVariant = value!;
//                               });
//                             },
//                           ),
//                           Text(variant),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//
//             SizedBox(height: 10),
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(8)),
//               child: const Text(
//                 "The price stated above depends on the condition of the product and is not final. "
//                 "The final price offer will be quoted at the end of the diagnosis.",
//                 style: TextStyle(fontSize: 12),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text("FAQs", style: TextStyle(fontSize: 2, fontWeight: FontWeight.bold)),
//             const Divider(),
//             faqItem("How did you calculate my device price?"),
//             faqItem("Is it safe to sell my phone on Fonofy?"),
//             faqItem("How does Voucher Payment work?"),
//             const SizedBox(height: 1),
//             Center(
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text("Load More FAQs", style: TextStyle(color: Colors.blue)),
//               ),
//             ),
//             const Spacer(),
//          SizedBox(
//   width: double.infinity,
//   child: ElevatedButton(
//     onPressed: () {
//       Get.to(() => SelectProduct2());
//     },
//     style: ElevatedButton.styleFrom(
//       backgroundColor: ColorConstants.appBlueColor3,
//       foregroundColor: Colors.white,
//       padding: const EdgeInsets.symmetric(vertical: 15),
//     ),
//     child: const Text("Get Exact Value"),
//   ),
// ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget faqItem(String question) {
//     return Column(
//       children: [
//         ListTile(
//           title: Text(question, style: const TextStyle(fontSize: 14)),
//           trailing: const Icon(Icons.keyboard_arrow_down),
//         ),
//         const Divider(),
//       ],
//     );
//   }
// }
import '../../../controllers/SellControllers/SellVariantTableControllers.dart';

class SelectProductScreen extends StatefulWidget {
  final String modelno;

  const SelectProductScreen({super.key, required this.modelno});

  @override
  _SelectProductScreenState createState() => _SelectProductScreenState();
}
class _SelectProductScreenState extends State<SelectProductScreen> {

  String? selectedVariant;

    SellVariantControllerTable sellVariantController = Get.put(SellVariantControllerTable());


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
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductCard(),
              const SizedBox(height: 18),
              const Text("Choose a variant", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),

              _buildVariantList(),

              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  "The price stated above depends on the condition of the product and is not final. "
                      "The final price offer will be quoted at the end of the diagnosis.",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              const Text("FAQs", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Divider(),
              faqItem("How did you calculate my device price?"),
              faqItem("Is it safe to sell my phone on Fonofy?"),
              faqItem("How does Voucher Payment work?"),
              const SizedBox(height: 1),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Load More FAQs", style: TextStyle(color: Colors.blue)),
                ),
              ),
                SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedVariant != null) {
                      final table1 = sellVariantController.tableVariantData?.table;
                      final modelName = table1 != null && table1.isNotEmpty
                          ? (table1.first.modelName?.isNotEmpty == true
                          ? table1.first.modelName!
                          : widget.modelno)
                          : widget.modelno;
                      final image = table1 != null && table1.isNotEmpty && table1.first.image != null
                          ? table1.first.image!
                          : null;

                      final variantParts = selectedVariant!.split(' / ');
                      final ram = variantParts.isNotEmpty ? variantParts[0].trim() : ' ';
                      final rom = variantParts.length > 1 ? variantParts[1].trim() : ' ';

                      Get.to(() => SelectProduct2(selectedVariant: selectedVariant!,modelNo: widget.modelno, ram: ram, rom: rom,
                       ));
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please select a variant.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appBlueColor3,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text("Get Exact Value"),
                ),
              ),

                SizedBox(height: 20),
            ],
          ),
        ),
      )),

    );
  }

  Widget _buildProductCard() {
    final table1 = sellVariantController.tableVariantData?.table1;
    if (table1 == null || table1.isEmpty) {
      return   Card(
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
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
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
                    product.modelName?.isNotEmpty == true ? product.modelName! : "Unknown Product",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
      return   Padding(
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
              margin:  EdgeInsets.symmetric(horizontal: 2),
              padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 2),
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
                    child: Text(variantString,
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
          title: Text(question, style:   TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.keyboard_arrow_down),
        ),
        const Divider(),
      ],
    );
  }
}