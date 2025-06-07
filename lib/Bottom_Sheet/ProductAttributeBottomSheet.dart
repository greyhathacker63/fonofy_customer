// import 'package:flutter/material.dart';
// import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
// import 'package:fonofy/model/ProductDetailsModel/ProductRamRomColorListModel.dart';
// import '../Api_Service/ProductDetailsService/ProductRamRomColorsService.dart';
// import '../utils/Colors.dart';
//
// class ProductAttributeBottomSheet extends StatefulWidget {
//   final ProductDetailsModel product;
//   // final Function onTap;
//   const ProductAttributeBottomSheet({
//     super.key,
//     required this.product,
//   });
//   @override
//   _ProductAttributeBottomSheetState createState() =>
//       _ProductAttributeBottomSheetState();
// }
//
// class _ProductAttributeBottomSheetState
//     extends State<ProductAttributeBottomSheet> {
//   String selectedCondition = "Fair";
//   String selectedStorage = "";
//   int selectedColorIndex = 0;
//   bool showDealsOnly = false;
//
//   final _serviceProductRamRom = ProductRamRomColorsService();
//
//   List<ProductRamRomColorListModel> _colorList = [];
//   ProductRamRomColorListModel? selectedVariant;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchColors();
//   }
//
//   Future<void> _fetchColors() async {
//     List<ProductRamRomColorListModel> colors =
//         await _serviceProductRamRom.fetchProductRamRomListColorsData(
//             widget.product.modelUrl.toString(),
//             widget.product.ucode.toString());
//
//     setState(() {
//       _colorList = colors;
//       selectedVariant = _colorList.firstWhere(
//         (item) =>
//             item.ramName == widget.product.ramName &&
//             item.romName == widget.product.romName &&
//             item.colorName == widget.product.colorName,
//         orElse: () => _colorList.first,
//       );
//       selectedStorage =
//           "${selectedVariant?.ramName ?? ''} / ${selectedVariant?.romName ?? ''}";
//       selectedColorIndex = _colorList.indexOf(selectedVariant!);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       expand: false,
//       initialChildSize: 0.9,
//       maxChildSize: 0.95,
//       minChildSize: 0.5,
//       builder: (context, scrollController) {
//         return SingleChildScrollView(
//           controller: scrollController,
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.product.productAndModelName ?? "",
//                 style:
//                     const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 "$selectedCondition / $selectedStorage / Color ${selectedVariant?.colorName ?? widget.product.colorName}",
//                 style: const TextStyle(fontSize: 14, color: Colors.black54),
//               ),
//               const SizedBox(height: 10),
//               Text.rich(
//                 TextSpan(
//                   text:
//                       "₹${_getSelectedConditionPrice()?.toStringAsFixed(0) ?? '0'} ",
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                   children: [
//                     TextSpan(
//                       text:
//                           " ₹${widget.product.newModelAmt?.toStringAsFixed(0) ?? '0'} ",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                         decoration: TextDecoration.lineThrough,
//                       ),
//                     ),
//                     TextSpan(
//                       text: "  You Save ₹ ${_calculateSavings()}",
//                       style: TextStyle(fontSize: 12, color: Colors.green[700]),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//               _sectionTitle("Condition"),
//               Wrap(
//                 spacing: 8,
//                 children: ["Fair", "Good", "Superb"].map((condition) {
//                   return ChoiceChip(
//                     label: Text(condition),
//                     selected: selectedCondition == condition,
//                     onSelected: (_) {
//                       setState(() => selectedCondition = condition);
//                     },
//                     selectedColor: Colors.teal.shade100,
//                     labelStyle: TextStyle(
//                       color: selectedCondition == condition
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   );
//                 }).toList(),
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: showDealsOnly,
//                     onChanged: (val) =>
//                         setState(() => showDealsOnly = val ?? false),
//                   ),
//                   const Text("Show deals only"),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               _buildWarrantyCard(),
//               const SizedBox(height: 10),
//               _sectionTitle("Storage"),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: _colorList.length,
//                 itemBuilder: (context, index) {
//                   String selectRom = _colorList[index].romName.toString();
//                   String storage =
//                       "${_colorList[index].ramName} / ${_colorList[index].romName}";
//                   bool isSelected = selectedStorage == storage;
//
//                   return OutlinedButton(
//
//                     onPressed: () {
//                       // widget.onTap();
//                       setState(() {
//                         if (selectRom == "64GB") {
//                           selectedCondition = "Fair";
//                         } else if (selectRom == "128GB") {
//                           selectedCondition = "Good";
//                         } else if (selectRom == "256GB") {
//                           selectedCondition = "Superb";
//                         }
//                         selectedStorage = storage;
//                         selectedVariant = _colorList[index];
//                         selectedColorIndex = index;
//                       });
//                     },
//                     style: OutlinedButton.styleFrom(
//                       side: BorderSide(
//                           color: isSelected ? Colors.teal : Colors.grey),
//                       backgroundColor: isSelected ? Colors.teal.shade50 : null,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           storage,
//                           style: TextStyle(
//                               color: isSelected ? Colors.teal : Colors.black),
//                         ),
//                         if (isSelected) ...[
//                           const SizedBox(width: 6),
//                           const Icon(Icons.check, color: Colors.teal, size: 18)
//                         ]
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 10),
//               _sectionTitle("Color"),
//               SizedBox(height: 10),
//               Wrap(
//                 spacing: 14,
//                 runSpacing: 12,
//                 children: _colorList.asMap().entries.map((entry) {
//                   int index = entry.key;
//                   var item = entry.value;
//                   bool isSelected = selectedColorIndex == index;
//                   Color circleColor =
//                       getColorFromName(item.colorName ?? "Grey");
//
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedColorIndex = index;
//                         selectedVariant = _colorList[index];
//                         selectedStorage =
//                             "${selectedVariant?.ramName} / ${selectedVariant?.romName}";
//                       });
//                     },
//                     child: Column(
//                       children: [
//                         Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             CircleAvatar(
//                               radius: 15,
//                               backgroundColor: circleColor,
//                               child: isSelected
//                                   ? const Icon(Icons.check,
//                                       color: Colors.black87, size: 16)
//                                   : null,
//                             ),
//                             Positioned(
//                               bottom: -12,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 2, vertical: 2),
//                                 decoration: BoxDecoration(
//                                   color: Colors.teal,
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 // child: Text(
//                                 //   "₹${item.newAmount ?? '0'}", // You can change to 'off' if needed
//                                 //   style: const TextStyle(fontSize: 10, color: Colors.white),
//                                 // ),
//                               ),
//                             )
//                           ],
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           item.colorName ?? "Color",
//                           style: const TextStyle(fontSize: 12),
//                         )
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _sectionTitle(String text) => Text(
//         text,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       );
//
//   Widget _buildWarrantyCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 1,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Icon(Icons.verified, color: Colors.teal),
//                 const SizedBox(width: 10),
//                 const Expanded(
//                   child: Text.rich(
//                     TextSpan(
//                       text: "Add ",
//                       children: [
//                         TextSpan(
//                           text: "6 Months",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         TextSpan(text: " extended warranty at ₹899"),
//                       ],
//                     ),
//                     style: TextStyle(fontSize: 14),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text("Add"),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "All devices have a default 6 Months warranty out of the box",
//               style: TextStyle(color: Colors.teal, fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   double? _getSelectedConditionPrice() {
//     if (selectedCondition == "Fair") {
//       return widget.product.sellingPrice;
//     } else if (selectedCondition == "Good") {
//       return widget.product.sellingPriceF1;
//     } else if (selectedCondition == "Superb") {
//       return widget.product.sellingPricePlus;
//     }
//     // default to sellingPrice if none selected
//     return widget.product.sellingPrice;
//   }
//
//   String _calculateSavings() {
//     final selectedPrice = _getSelectedConditionPrice() ?? 0;
//     final newPrice = widget.product.newModelAmt ?? 0;
//     final savings = newPrice - selectedPrice;
//     return savings > 0 ? savings.toStringAsFixed(0) : '0';
//   }
// }

import 'package:flutter/material.dart';
import '../Api_Service/ProductDetailsService/ProductRamRomColorsService.dart';
import '../model/ProductDetailsModel/ProductDetailsModel.dart';
import '../model/ProductDetailsModel/ProductRamRomColorListModel.dart';
import '../utils/Colors.dart';

// class ProductAttributeBottomSheet extends StatefulWidget {
//   final ProductDetailsModel product;
//   final void Function(
//       String ramName,
//       String romName,
//       String colorName,
//       double? price,
//       String condition,
//       String ramId,
//       String romId,
//       String colorId,
//       dynamic discountPercentage,
//       ) onVariantSelected;
//
//   const ProductAttributeBottomSheet({
//     super.key,
//     required this.product,
//     required this.onVariantSelected,
//   });
//
//   @override
//   _ProductAttributeBottomSheetState createState() => _ProductAttributeBottomSheetState();
// }
//
// class _ProductAttributeBottomSheetState extends State<ProductAttributeBottomSheet> {
//   String selectedCondition = "Fair";
//   String selectedStorage = "";
//   int selectedColorIndex = 0;
//   bool showDealsOnly = false;
//
//   final _serviceProductRamRom = ProductRamRomColorsService();
//
//   List<ProductRamRomColorListModel> _colorList = [];
//   ProductRamRomColorListModel? selectedVariant;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchColors();
//   }
//
//   Future<void> _fetchColors() async {
//     try {
//       List<ProductRamRomColorListModel> colors =
//       await _serviceProductRamRom.fetchProductRamRomListColorsData(
//         widget.product.modelUrl ?? '',
//         widget.product.ucode ?? '',
//       );
//
//       setState(() {
//         _colorList = colors;
//         if (_colorList.isNotEmpty) {
//           selectedVariant = _colorList.firstWhere(
//                 (item) =>
//             item.ramName == widget.product.ramName &&
//                 item.romName == widget.product.romName &&
//                 item.colorName == widget.product.colorName,
//             orElse: () => _colorList.first,
//           );
//           selectedStorage =
//           "${selectedVariant?.ramName ?? 'N/A'} / ${selectedVariant?.romName ?? 'N/A'}";
//           selectedColorIndex = _colorList.indexOf(selectedVariant!);
//           selectedCondition = "Fair"; // Default condition
//           _notifyParent(); // Notify parent with initial selection
//         }
//       });
//     } catch (e) {
//       print("Error fetching colors: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       expand: false,
//       initialChildSize: 0.9,
//       maxChildSize: 0.95,
//       minChildSize: 0.5,
//       builder: (context, scrollController) {
//         return SingleChildScrollView(
//           controller: scrollController,
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.product.productAndModelName ?? "Product",
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 "$selectedCondition / $selectedStorage / Color ${selectedVariant?.colorName ?? widget.product.colorName ?? 'N/A'}",
//                 style: const TextStyle(fontSize: 14, color: Colors.black54),
//               ),
//               const SizedBox(height: 10),
//               Text.rich(
//                 TextSpan(
//                   text: "₹${_getSelectedConditionPrice()?.toStringAsFixed(0) ?? '0'} ",
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: " ₹${widget.product.newModelAmt?.toStringAsFixed(0) ?? '0'} ",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                         decoration: TextDecoration.lineThrough,
//                       ),
//                     ),
//                     TextSpan(
//                       text: "  You Save ₹${_calculateSavings()}",
//                       style: TextStyle(fontSize: 12, color: Colors.green[700]),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),
//               _sectionTitle("Condition"),
//               Wrap(
//                 spacing: 8,
//                 children: ["Fair", "Good", "Superb"].map((condition) {
//                   return ChoiceChip(
//                     label: Text(condition),
//                     selected: selectedCondition == condition,
//                     onSelected: (_) {
//                       setState(() {
//                         selectedCondition = condition;
//                         _notifyParent();
//                       });
//                     },
//                     selectedColor: Colors.teal.shade100,
//                     labelStyle: TextStyle(
//                       color: selectedCondition == condition ? Colors.white : Colors.black,
//                     ),
//                   );
//                 }).toList(),
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: showDealsOnly,
//                     onChanged: (val) => setState(() => showDealsOnly = val ?? false),
//                   ),
//                   const Text("Show deals only"),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               _buildWarrantyCard(),
//               const SizedBox(height: 10),
//               _sectionTitle("Storage"),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: _colorList.asMap().entries.map((entry) {
//                   int index = entry.key;
//                   var item = entry.value;
//                   String storage = "${item.ramName ?? 'N/A'} / ${item.romName ?? 'N/A'}";
//                   bool isSelected = selectedStorage == storage;
//
//                   return OutlinedButton(
//                     onPressed: () {
//                       setState(() {
//                         selectedStorage = storage;
//                         selectedVariant = _colorList[index];
//                         selectedColorIndex = index;
//                         _notifyParent();
//                       });
//                     },
//                     style: OutlinedButton.styleFrom(
//                       side: BorderSide(color: isSelected ? Colors.teal : Colors.grey),
//                       backgroundColor: isSelected ? Colors.teal.shade50 : null,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           storage,
//                           style: TextStyle(color: isSelected ? Colors.teal : Colors.black),
//                         ),
//                         if (isSelected) ...[
//                           const SizedBox(width: 6),
//                           const Icon(Icons.check, color: Colors.teal, size: 18)
//                         ]
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 10),
//               _sectionTitle("Color"),
//               const SizedBox(height: 10),
//               Wrap(
//                 spacing: 14,
//                 runSpacing: 12,
//                 children: _colorList.asMap().entries.map((entry) {
//                   int index = entry.key;
//                   var item = entry.value;
//                   bool isSelected = selectedColorIndex == index;
//                   Color circleColor = getColorFromName(item.colorName ?? "Grey");
//
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedColorIndex = index;
//                         selectedVariant = _colorList[index];
//                         selectedStorage =
//                         "${selectedVariant?.ramName ?? 'N/A'} / ${selectedVariant?.romName ?? 'N/A'}";
//                         _notifyParent();
//                       });
//                     },
//                     child: Column(
//                       children: [
//                         Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             CircleAvatar(
//                               radius: 15,
//                               backgroundColor: circleColor,
//                               child: isSelected
//                                   ? const Icon(Icons.check, color: Colors.black87, size: 16)
//                                   : null,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           item.colorName ?? "Color",
//                           style: const TextStyle(fontSize: 12),
//                         )
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _notifyParent() {
//     print("Notifying parent: Condition=$selectedCondition, "
//         "Price=${_getSelectedConditionPrice()}, "
//         "RAM=${selectedVariant?.ramName}, ROM=${selectedVariant?.romName}, Color=${selectedVariant?.colorName}");
//     widget.onVariantSelected(
//       selectedVariant?.ramName ?? widget.product.ramName ?? '',
//       selectedVariant?.romName ?? widget.product.romName ?? '',
//       selectedVariant?.colorName ?? widget.product.colorName ?? '',
//       _getSelectedConditionPrice(),
//       selectedCondition,
//       selectedVariant?.ramId?.toString() ?? widget.product.ramId?.toString() ?? '',
//       selectedVariant?.romId?.toString() ?? widget.product.romId?.toString() ?? '',
//       selectedVariant?.colorId?.toString() ?? widget.product.colorId?.toString() ?? '',
//       widget.product.discountPercentage,
//     );
//   }
//
//   Widget _sectionTitle(String text) => Text(
//     text,
//     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//   );
//
//   Widget _buildWarrantyCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 1,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Icon(Icons.verified, color: Colors.teal),
//                 const SizedBox(width: 10),
//                 const Expanded(
//                   child: Text.rich(
//                     TextSpan(
//                       text: "Add ",
//                       children: [
//                         TextSpan(
//                           text: "6 Months",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         TextSpan(text: " extended warranty at ₹899"),
//                       ],
//                     ),
//                     style: TextStyle(fontSize: 14),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text("Add"),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "All devices have a default 6 Months warranty out of the box",
//               style: TextStyle(color: Colors.teal, fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   double? _getSelectedConditionPrice() {
//     double? price;
//
//     if (selectedVariant != null) {
//       if (selectedCondition == "Fair") {
//         price = selectedVariant?.f2 ?? widget.product.sellingPrice ?? 0.0;
//       } else if (selectedCondition == "Good") {
//
//         price = selectedVariant!.f1 ?? widget.product.sellingPriceF1 ?? widget.product.sellingPricePlus ?? 0.0;
//       } else if (selectedCondition == "Superb") {
//
//         price = selectedVariant!.f1Plus ?? widget.product.sellingPricePlus ?? widget.product.sellingPrice ??
//             0.0;
//       }
//     } else {
//        if (selectedCondition == "Fair") {
//         price = widget.product.sellingPrice ?? 0.0;
//       } else if (selectedCondition == "Good") {
//         price = widget.product.sellingPriceF1 ?? widget.product.sellingPriceF1 ?? 0.0;
//       } else if (selectedCondition == "Superb") {
//         price = widget.product.sellingPricePlus ?? widget.product.sellingPricePlus ?? 0.0;
//       }
//     }
//
//     print("Selected Condition: $selectedCondition, Storage: $selectedStorage, Price: $price");
//     return price;
//   }
//
//   String _calculateSavings() {
//     final selectedPrice = _getSelectedConditionPrice() ?? 0;
//     final newPrice = widget.product.newModelAmt ?? 0;
//     final savings = newPrice - selectedPrice;
//     return savings > 0 ? savings.toStringAsFixed(0) : '0';
//   }
//
//
// }

class ProductAttributeBottomSheet extends StatefulWidget {
  final ProductDetailsModel product;
    void Function(
      String ramName,
      String romName,
      String colorName,
      double? price,
      String condition,
      String ramId,
      String romId,
      String colorId,
      dynamic discountPercentage,
      ) onVariantSelected;

    ProductAttributeBottomSheet({
    super.key,
    required this.product,
    required this.onVariantSelected,
  });

  @override
  _ProductAttributeBottomSheetState createState() => _ProductAttributeBottomSheetState();
}

class _ProductAttributeBottomSheetState extends State<ProductAttributeBottomSheet> {

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
    try {
      List<ProductRamRomColorListModel> colors =
      await _serviceProductRamRom.fetchProductRamRomListColorsData(
        widget.product.modelUrl ?? '',
        widget.product.ucode ?? '',
      );

      setState(() {
        _colorList = colors;
        if (_colorList.isNotEmpty) {
          selectedVariant = _colorList.firstWhere(
                (item) =>
            item.ramName == widget.product.ramName &&
                item.romName == widget.product.romName &&
                item.colorName == widget.product.colorName,
            orElse: () => _colorList.first,
          );
          selectedStorage =
          "${selectedVariant?.ramName ?? ''} / ${selectedVariant?.romName ?? ''}";
          selectedColorIndex = _colorList.indexOf(selectedVariant!);
          _updateConditionBasedOnStorage();
          _notifyParent();
        }
      });
    } catch (e) {
      print("Error fetching colors: $e");
    }
  }

  void _updateConditionBasedOnStorage() {
    if (selectedVariant == null) {
      selectedCondition = "Fair";
      return;
    }
    final ram = selectedVariant!.ramName?.toLowerCase().replaceAll('gb', '').trim();
    final rom = selectedVariant!.romName?.toLowerCase().replaceAll('gb', '').trim();

    if (ram == "4" && rom == "64") {
      selectedCondition = "Fair";
    } else if (ram == "8" && rom == "128") {
      selectedCondition = "Good";
    } else if (ram == "16" && rom == "256") {
      selectedCondition = "Superb";
    } else {
      selectedCondition = "Fair";
    }
    print("Updated condition based on storage: $selectedCondition");
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
              Text(widget.product.productAndModelName ?? "Product",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "$selectedCondition / $selectedStorage / Color ${selectedVariant?.colorName ?? widget.product.colorName ?? ''}",
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "₹${_getSelectedConditionPrice()?.toStringAsFixed(0) ?? '0'} ",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: " ₹${widget.product.newModelAmt?.toStringAsFixed(0) ?? '0'} ",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    TextSpan(
                      text: "  You Save ₹${_calculateSavings()}",
                      style: TextStyle(fontSize: 12, color: Colors.green[700]),
                    ),
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
                      setState(() {
                        selectedCondition = condition;
                        _notifyParent();
                      });
                    },
                    selectedColor: Colors.teal.shade100,
                    labelStyle: TextStyle(
                      color: selectedCondition == condition ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              Row(
                children: [
                  Checkbox(
                    value: showDealsOnly,
                    onChanged: (val) => setState(() => showDealsOnly = val ?? false),
                  ),
                  const Text("Show deals only"),
                ],
              ),
              const SizedBox(height: 10),
              _buildWarrantyCard(),
              const SizedBox(height: 10),
              _sectionTitle("Storage"),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _colorList.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;
                  String storage = "${item.ramName ?? 'N/A'} / ${item.romName ?? 'N/A'}";
                  bool isSelected = selectedStorage == storage;

                  return OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedStorage = storage;
                        selectedVariant = _colorList[index];
                        selectedColorIndex = index;
                        _updateConditionBasedOnStorage();
                        _notifyParent();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: isSelected ? Colors.teal : Colors.grey),
                      backgroundColor: isSelected ? Colors.teal.shade50 : null,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          storage,
                          style: TextStyle(color: isSelected ? Colors.teal : Colors.black),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.check, color: Colors.teal, size: 18)
                        ]
                      ],
                    ),
                  );
                }).toList(),
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
                  Color circleColor = getColorFromName(item.colorName ?? "");

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColorIndex = index;
                        selectedVariant = _colorList[index];
                        selectedStorage =
                        "${selectedVariant?.ramName ?? ''} / ${selectedVariant?.romName ?? ''}";
                        _updateConditionBasedOnStorage();
                        _notifyParent();
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
                                  ? const Icon(Icons.check, color: Colors.black87, size: 16)
                                  : null,
                            ),
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
            ],
          ),
        );
      },
    );
  }

  void _notifyParent() {
    print("Notifying parent: Condition=$selectedCondition, "

        "Price=${_getSelectedConditionPrice()}, ""RAM=${selectedVariant?.ramName}, ROM=${selectedVariant?.romName}, Color=${selectedVariant?.colorName}");
    widget.onVariantSelected(
      selectedVariant?.ramName ?? widget.product.ramName ?? '',
      selectedVariant?.romName ?? widget.product.romName ?? '',
      selectedVariant?.colorName ?? widget.product.colorName ?? '',
      _getSelectedConditionPrice(),
      selectedCondition,
      selectedVariant?.ramId?.toString() ?? widget.product.ramId?.toString() ?? '',
      selectedVariant?.romId?.toString() ?? widget.product.romId?.toString() ?? '',
      selectedVariant?.colorId?.toString() ?? widget.product.colorId?.toString() ?? '',
      widget.product.discountPercentage,
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
                        TextSpan(text: "6 Months",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: " extended warranty at ₹899"),
                      ],
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child:  Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "All devices have a default 6 Months warranty out of the box",
              style: TextStyle(color: Colors.teal, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  double? _getSelectedConditionPrice() {
    double? price;
    if (selectedVariant != null) {
      if (selectedCondition == "Fair") {
        price = selectedVariant!.f2 ?? widget.product.sellingPrice ?? 0.0;
      } else if (selectedCondition == "Good") {
        price = selectedVariant!.f1 ?? widget.product.sellingPriceF1 ?? widget.product.sellingPrice ?? 0.0;
      } else if (selectedCondition == "Superb") {
        price = selectedVariant!.f1Plus ?? widget.product.sellingPricePlus ?? widget.product.sellingPrice ?? 0.0;
      }
    } else {
      if (selectedCondition == "Fair") {
        price = widget.product.sellingPrice ?? 0.0;
      } else if (selectedCondition == "Good") {
        price = widget.product.sellingPriceF1 ?? widget.product.sellingPrice ?? 0.0;
      } else if (selectedCondition == "Superb") {
        price = widget.product.sellingPricePlus ?? widget.product.sellingPrice ?? 0.0;
      }
    }
    print("Selected Condition: $selectedCondition, Storage: $selectedStorage, Price: $price");
    return price;
  }
  String _calculateSavings() {
    final selectedPrice = _getSelectedConditionPrice() ?? 0;
    final newPrice = widget.product.newModelAmt ?? 0;
    final savings = newPrice - selectedPrice;
    return savings > 0 ? savings.toStringAsFixed(0) : '0';
  }

}


