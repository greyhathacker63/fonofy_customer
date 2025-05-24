import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/Device/DeviceDetailsScreen.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

import '../../../controllers/SellControllers/SellVariantPriceControllers.dart';
import '../../../widgets/SellWidgets/buildFaqItem.dart';
import '../../../widgets/SellWidgets/buildOfferRow.dart';

// class SelectProduct2 extends StatelessWidget {
//
//   const SelectProduct2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text("Select Product", style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//
//
//         child: Column(
//
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Card
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Row(
//                 children: [
//                   Image.asset("assets/images/Phone3.png", height: 80),
//                     SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                           Text(
//                           "Apple iPhone 6 Plus\n(1 GB/64 GB)",
//                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
//                         ),
//                           SizedBox(height: 5),
//                           Text("Get Upto", style: TextStyle(color: Colors.black54)),
//                         Row(
//                           children: [
//                             SizedBox(width: 8),
//                             Text("₹2,899",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red,
//                               ),
//                             ),
//                             Text(" ₹3,130",
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 color: Colors.grey,
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 5),
//                          Text("7400+ already sold on Fonofy",
//                           style: TextStyle(color: Colors.green, fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//               SizedBox(height: 10),
//
//             // Price Disclaimer
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.amber.shade100,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: const Text(
//                 "The price stated above depends on the condition of the product and is not final. "
//                 "The final price offer will be quoted at the end of the diagnosis.",
//                 style: TextStyle(fontSize: 12, color: Colors.black54),
//               ),
//             ),
//
//               SizedBox(height: 15),
//
//             // New Phone Offer
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   Image.asset("assets/images/Iphone2.png", height: 50), // Replace with actual image
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Purchasing New iPhone?",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         const Text(
//                           "Get upto ₹4000* Bonus & avail it at various stores",
//                           style: TextStyle(fontSize: 12, color: Colors.black54),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//               SizedBox(height: 15),
//
//             // Special Offers
//             const Text("Special Offer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//             const SizedBox(height: 10),
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Column(
//                 children: [
//                   buildOfferRow("assets/images/instantBank.png", "Instant bank transfer"),
//                   buildOfferRow("assets/images/GiftCard.png", "Get 3.5% Extra Amazon Pay Gift Card"),
//                   buildOfferRow("assets/images/FlipkartGiftCard.png", "Get 3.5% Extra Flipkart Gift Card"),
//                   buildOfferRow("assets/images/VoucherCroma.png", "Get 1% Extra with this voucher Croma"),
//                   buildOfferRow("assets/images/UPI.png", "UPI"),
//                 ],
//               ),
//             ),
//
//               SizedBox(height: 15),
//
//             // FAQs
//             const Text("FAQs", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//             const SizedBox(height: 10),
//             buildFaqItem("How did you calculate my device price?"),
//             buildFaqItem("Is it safe to sell my phone on Fonofy?"),
//             buildFaqItem("How does Voucher Payment work?"),
//
//               SizedBox(height: 10),
//
//             // Load More FAQs
//             Center(
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text("Load More FAQs", style: TextStyle(color: Colors.blue)),
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             // Get Exact Value Button
// SizedBox(
//   width: double.infinity,
//   child: ElevatedButton(
//     style: ElevatedButton.styleFrom(
//       backgroundColor:ColorConstants.appBlueColor3,
//       padding: const EdgeInsets.symmetric(vertical: 12),
//     ),
//     onPressed: () {
//       Get.to(() => DeviceDetailsScreen()); // ✅ Navigate to DeviceDetailsScreen
//     },
//     child: const Text(
//       "Get Exact Value",
//       style: TextStyle(color: Colors.white, fontSize: 16),
//     ),
//   ),
// ),
//           ]
//         ),
//       ),
//     );
//   }
//
// }

// class SelectProduct2 extends StatefulWidget {
//   final String selectedVariant;
//   final String modelNo;
//   final String ram;
//   final String rom;
//
//   const SelectProduct2({
//     super.key,
//     required this.selectedVariant,
//     required this.modelNo,
//     required this.ram,
//     required this.rom,
//   });
//
//   @override
//   _SelectProduct2State createState() => _SelectProduct2State();
// }
//
// class _SelectProduct2State extends State<SelectProduct2> {
//   final SellVariantControllerPrice controllerSellVariantPrice = Get.put(SellVariantControllerPrice());
//
//   @override
//   void initState() {
//     super.initState();
//     controllerSellVariantPrice.getPriceVariantData(
//         widget.modelNo, widget.ram, widget.rom);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title:
//             const Text("Select Product", style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Obx(
//         () => controllerSellVariantPrice.isVariantPriceLoading.value
//             ? const Center(child: CircularProgressIndicator())
//             : controllerSellVariantPrice.priceVariantData == null
//                 ? const Center(child: Text("No price data available"))
//                 : SingleChildScrollView(
//                     padding: const EdgeInsets.all(12),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Product Card
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.grey.shade300),
//                           ),
//                           child: Row(
//                             children: [
//                               _buildProductImage(),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "${controllerSellVariantPrice.priceVariantData?.modelName ?? widget.modelNo}\n"
//                                       "(${controllerSellVariantPrice.priceVariantData?.ramName ?? widget.ram} / "
//                                       "${controllerSellVariantPrice.priceVariantData?.romName ?? widget.rom})",
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                         color: Colors.blue,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 5),
//                                     const Text("Get Upto",
//                                         style:
//                                             TextStyle(color: Colors.black54)),
//                                     Row(
//                                       children: [
//                                         const SizedBox(width: 8),
//                                         Text(
//                                           "₹${controllerSellVariantPrice.priceVariantData?.maxPrice?.toStringAsFixed(0) ?? '2899'}",
//                                           style: const TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.red,
//                                           ),
//                                         ),
//                                         Text(
//                                           controllerSellVariantPrice
//                                                       .priceVariantData
//                                                       ?.basePrice !=
//                                                   null
//                                               ? " ₹${controllerSellVariantPrice.priceVariantData!.basePrice!.toStringAsFixed(0)}"
//                                               : " ₹3130",
//                                           style: const TextStyle(
//                                             fontSize: 17,
//                                             color: Colors.grey,
//                                             decoration:
//                                                 TextDecoration.lineThrough,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 5),
//                                     // Text(
//                                     //   "${controllerSellVariantPrice.priceVariantData?.soldCount ?? '7400'}+ already sold on Fonofy",
//                                     //   style: const TextStyle(color: Colors.green, fontSize: 12),
//                                     // ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         // Price Disclaimer
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.amber.shade100,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: const Text(
//                             "The price stated above depends on the condition of the product and is not final. "
//                             "The final price offer will be quoted at the end of the diagnosis.",
//                             style:
//                                 TextStyle(fontSize: 12, color: Colors.black54),
//                           ),
//                         ),
//                         const SizedBox(height: 15),
//                         // New Phone Offer
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Row(
//                             children: [
//                               Image.asset("assets/images/Iphone2.png",
//                                   height: 50, width: 50),
//                               const SizedBox(width: 10),
//                               const Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Purchasing New iPhone?",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(
//                                       "Get upto ₹4000* Bonus & avail it at various stores",
//                                       style: TextStyle(
//                                           fontSize: 12, color: Colors.black54),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 15),
//                         // Special Offers
//                         const Text("Special Offer",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16)),
//                         const SizedBox(height: 10),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.grey.shade300),
//                           ),
//                           child: Column(
//                             children: [
//                               buildOfferRow("assets/images/instantBank.png",
//                                   "Instant bank transfer"),
//                               buildOfferRow("assets/images/GiftCard.png",
//                                   "Get 3.5% Extra Amazon Pay Gift Card"),
//                               buildOfferRow(
//                                   "assets/images/FlipkartGiftCard.png",
//                                   "Get 3.5% Extra Flipkart Gift Card"),
//                               buildOfferRow("assets/images/VoucherCroma.png",
//                                   "Get 1% Extra with this voucher Croma"),
//                               buildOfferRow("assets/images/UPI.png", "UPI"),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 15),
//                         // FAQs
//                         const Text("FAQs",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16)),
//                         const SizedBox(height: 10),
//                         buildFaqItem("How did you calculate my device price?"),
//                         buildFaqItem("Is it safe to sell my phone on Fonofy?"),
//                         buildFaqItem("How does Voucher Payment work?"),
//                         const SizedBox(height: 10),
//                         // Load More FAQs
//                         Center(
//                           child: TextButton(
//                             onPressed: () {},
//                             child: const Text("Load More FAQs",
//                                 style: TextStyle(color: Colors.blue)),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         // Get Exact Value Button
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: ColorConstants.appBlueColor3,
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                             ),
//                             onPressed: () {
//                               Get.to(() => DeviceDetailsScreen());
//                             },
//                             child: const Text(
//                               "Get Exact Value",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 16),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//       ),
//     );
//   }
//
//   Widget _buildProductImage() {
//     final imagePath = controllerSellVariantPrice.priceVariantData?.image ?? '';
//     final imageUrl = imagePath != null && imagePath.isNotEmpty
//         ? '$imageAllBaseUrl$imagePath'
//         : null;
//     debugPrint('SelectProduct2 Image URL: $imageUrl');
//
//     return imageUrl != null
//         ? Image.network(
//             imageUrl,
//             height: 80,
//             width: 80,
//             fit: BoxFit.cover,
//             loadingBuilder: (context, child, loadingProgress) {
//               if (loadingProgress == null) return child;
//               return const SizedBox(
//                 height: 80,
//                 width: 80,
//                 child: Center(child: CircularProgressIndicator()),
//               );
//             },
//             errorBuilder: (context, error, stackTrace) {
//               debugPrint('SelectProduct2 Image Error: $error, URL: $imageUrl');
//               return Image.asset(
//                 "assets/images/Phone3.png",
//                 height: 80,
//                 width: 80,
//                 fit: BoxFit.cover,
//               );
//             },
//           )
//         : Image.asset(
//             "assets/images/Phone3.png",
//             height: 80,
//             width: 80,
//             fit: BoxFit.cover,
//           );
//   }
//
//
// }




// class SelectProduct2 extends StatefulWidget {
//   final String selectedVariant;
//   final String modelNo;
//    final String ram;
//   final String rom;
//
//   const SelectProduct2({
//     super.key,
//     required this.selectedVariant,
//     required this.modelNo,
//      required this.ram,
//     required this.rom,
//    });
//
//   @override
//   _SelectProduct2State createState() => _SelectProduct2State();
// }
//
// class _SelectProduct2State extends State<SelectProduct2> {
//
//    final SellVariantControllerPrice controllerSellVariantPrice = Get.put(SellVariantControllerPrice());
//
//   @override
//   void initState() {
//     super.initState();
//     controllerSellVariantPrice.getPriceVariantData(widget.modelNo, widget.ram, widget.rom);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text("Select Product", style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Obx(() => controllerSellVariantPrice.isVariantPriceLoading.value
//           ? const Center(child: CircularProgressIndicator())
//           : controllerSellVariantPrice.priceVariantData == null
//           ? const Center(child: Text("No price data available. Please try again or contact support."))
//           : SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Card
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Row(
//                 children: [
//                   _buildProductImage(),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${controllerSellVariantPrice.priceVariantData?.modelName ?? widget.modelNo }\n"
//                               "(${controllerSellVariantPrice.priceVariantData?.ramName ?? widget.ram} / "
//                               "${controllerSellVariantPrice.priceVariantData?.romName ?? widget.rom})",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         const Text("Get Upto", style: TextStyle(color: Colors.black54)),
//                         Row(
//                           children: [
//                             const SizedBox(width: 8),
//                             Text(
//                               "₹${controllerSellVariantPrice.priceVariantData?.maxPrice?.toStringAsFixed(0) ?? '2899'}",
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red,
//                               ),
//                             ),
//                             Text(
//                               controllerSellVariantPrice.priceVariantData?.basePrice != null
//                                   ? " ₹${controllerSellVariantPrice.priceVariantData!.basePrice!.toStringAsFixed(0)}"
//                                   : " ₹3130",
//                               style: const TextStyle(
//                                 fontSize: 17,
//                                 color: Colors.grey,
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Price Disclaimer
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.amber.shade100,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: const Text(
//                 "The price stated above depends on the condition of the product and is not final. "
//                     "The final price offer will be quoted at the end of the diagnosis.",
//                 style: TextStyle(fontSize: 12, color: Colors.black54),
//               ),
//             ),
//             const SizedBox(height: 15),
//             // New Phone Offer
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   Image.asset("assets/images/Iphone2.png", height: 50, width: 50),
//                   const SizedBox(width: 10),
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Purchasing New iPhone?",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           "Get upto ₹4000* Bonus & avail it at various stores",
//                           style: TextStyle(fontSize: 12, color: Colors.black54),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 15),
//             // Special Offers
//             const Text("Special Offer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//             const SizedBox(height: 10),
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Column(
//                 children: [
//                   buildOfferRow("assets/images/instantBank.png", "Instant bank transfer"),
//                   buildOfferRow("assets/images/GiftCard.png", "Get 3.5% Extra Amazon Pay Gift Card"),
//                   buildOfferRow("assets/images/FlipkartGiftCard.png", "Get 3.5% Extra Flipkart Gift Card"),
//                   buildOfferRow("assets/images/VoucherCroma.png", "Get 1% Extra with this voucher Croma"),
//                   buildOfferRow("assets/images/UPI.png", "UPI"),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 15),
//             // FAQs
//             const Text("FAQs", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//             const SizedBox(height: 10),
//             buildFaqItem("How did you calculate my device price?"),
//             buildFaqItem("Is it safe to sell my phone on Fonofy?"),
//             buildFaqItem("How does Voucher Payment work?"),
//             const SizedBox(height: 10),
//             // Load More FAQs
//             Center(
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text("Load More FAQs", style: TextStyle(color: Colors.blue)),
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Get Exact Value Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: ColorConstants.appBlueColor3,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                 ),
//                 onPressed: () {
//                   Get.to(() => DeviceDetailsScreen());
//                 },
//                 child: const Text(
//                   "Get Exact Value",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
//
//   Widget _buildProductImage() {
//     final imagePath = controllerSellVariantPrice.priceVariantData?.image ?? '';
//     final imageUrl = imagePath != null && imagePath.isNotEmpty
//         ? '$imageAllBaseUrl/$imagePath'.replaceAll('//', '/')
//         : null;
//     debugPrint('SelectProduct2 Image URL: $imageUrl');
//
//     return imageUrl != null
//         ? Image.network(
//       imageUrl,
//       height: 80,
//       width: 80,
//       fit: BoxFit.cover,
//       loadingBuilder: (context, child, loadingProgress) {
//         if (loadingProgress == null) return child;
//         return const SizedBox(
//           height: 80,
//           width: 80,
//           child: Center(child: CircularProgressIndicator()),
//         );
//       },
//       errorBuilder: (context, error, stackTrace) {
//         debugPrint('SelectProduct2 Image Error: $error, URL: $imageUrl');
//         return Image.asset(
//           "assets/images/Phone3.png",
//           height: 80,
//           width: 80,
//           fit: BoxFit.cover,
//         );
//       },
//     )
//         : Image.asset(
//       "assets/images/Phone3.png",
//       height: 80,
//       width: 80,
//       fit: BoxFit.cover,
//     );
//   }
//
//   Widget buildOfferRow(String imagePath, String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         children: [
//           Image.asset(imagePath, height: 30, width: 30),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               title,
//               style: const TextStyle(fontSize: 14),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildFaqItem(String question) {
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




import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SelectProduct2 extends StatefulWidget {
  final String selectedVariant;
  final String modelNo;
   final String ram;
  final String rom;

  const SelectProduct2({
    super.key,
    required this.selectedVariant,
    required this.modelNo,

    required this.ram,
    required this.rom,
   });

  @override
  _SelectProduct2State createState() => _SelectProduct2State();
}

class _SelectProduct2State extends State<SelectProduct2> {
  static const String imageAllBaseUrl = 'https://api.fonofy.in';
  late SellVariantControllerPrice sellVariantPriceController;

  @override
  void initState() {
    super.initState();
    sellVariantPriceController = Get.put(SellVariantControllerPrice());
    // Use async to avoid blocking main thread
    Future.microtask(() {
      sellVariantPriceController.getPriceVariantData(widget.modelNo, widget.ram, widget.rom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Select Product", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() => sellVariantPriceController.isVariantPriceLoading.value
          ?   Center(child: CircularProgressIndicator())
          : sellVariantPriceController.priceVariantData == null
          ?   Center(child: Text("No price data available. Please try again or contact support."))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  _buildProductImage(sellVariantPriceController),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${sellVariantPriceController.priceVariantData?.modelName ?? widget.modelNo}\n"
                              "(${sellVariantPriceController.priceVariantData?.ramName ?? widget.ram} / "
                              "${sellVariantPriceController.priceVariantData?.romName ?? widget.rom})",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text("Get Upto", style: TextStyle(color: Colors.black54)),
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Text(
                              "₹${sellVariantPriceController.priceVariantData?.maxPrice?.toStringAsFixed(0) ?? '2899'}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              sellVariantPriceController.priceVariantData?.basePrice != null
                                  ? " ₹${sellVariantPriceController.priceVariantData!.basePrice!.toStringAsFixed(0)}"
                                  : " ₹3130",
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Price Disclaimer
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                "The price stated above depends on the condition of the product and is not final. "
                    "The final price offer will be quoted at the end of the diagnosis.",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 15),
            // New Phone Offer
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/Iphone2.png", height: 50, width: 50),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Purchasing New iPhone?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Get upto ₹4000* Bonus & avail it at various stores",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // Special Offers
            const Text("Special Offer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  buildOfferRow("assets/images/instantBank.png", "Instant bank transfer"),
                  buildOfferRow("assets/images/GiftCard.png", "Get 3.5% Extra Amazon Pay Gift Card"),
                  buildOfferRow("assets/images/FlipkartGiftCard.png", "Get 3.5% Extra Flipkart Gift Card"),
                  buildOfferRow("assets/images/VoucherCroma.png", "Get 1% Extra with this voucher Croma"),
                  buildOfferRow("assets/images/UPI.png", "UPI"),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // FAQs
            const Text("FAQs", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            buildFaqItem("How did you calculate my device price?"),
            buildFaqItem("Is it safe to sell my phone on Fonofy?"),
            buildFaqItem("How does Voucher Payment work?"),
            const SizedBox(height: 10),
            // Load More FAQs
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Load More FAQs", style: TextStyle(color: Colors.blue)),
              ),
            ),
            const SizedBox(height: 10),
            // Get Exact Value Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.appBlueColor3,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Get.to(() => DeviceDetailsScreen());
                },
                child: const Text(
                  "Get Exact Value",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildProductImage(SellVariantControllerPrice controller) {
    final imagePath = controller.priceVariantData?.image ?? '';
    final imageUrl = imagePath != null && imagePath.isNotEmpty
        ? imagePath.startsWith('/')
        ? '$imageAllBaseUrl$imagePath'
        : '$imageAllBaseUrl/$imagePath'
        : null;
    debugPrint('SelectProduct2 Image URL: $imageUrl');

    return imageUrl != null
        ? Image.network(imageUrl,
      height: 80,
      width: 80,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return   SizedBox(
          height: 80,
          width: 80,
          child: Center(child: CircularProgressIndicator()),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('SelectProduct2 Image Error: $error, URL: $imageUrl');
        return Image.asset(
          "assets/images/Phone3.png",
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        );
      },
    )
        : Image.asset(
      "assets/images/Phone3.png",
      height: 80,
      width: 80,
      fit: BoxFit.cover,
    );
  }

  Widget buildOfferRow(String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Image.asset(imagePath, height: 30, width: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFaqItem(String question) {
    return Column(
      children: [
        ListTile(
          title: Text(question, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.keyboard_arrow_down),
        ),
        const Divider(),
      ],
    );
  }
}