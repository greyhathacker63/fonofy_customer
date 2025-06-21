// import 'package:flutter/material.dart';
// import 'package:fonofy/controllers/OrderController/SellOrderController.dart';
// import 'package:fonofy/controllers/OrderController/SellOrderDetailController.dart';
// import 'package:fonofy/controllers/RepairController/RepairCancelReasonListController.dart';
// import 'package:fonofy/utils/Colors.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';


// class CancelSellOrderScreen extends StatefulWidget {
//   final String orderId;
//   final String customerId;

//   const CancelSellOrderScreen({
//     Key? key,
//     required this.orderId,
//     required this.customerId,
//   }) : super(key: key);

//   @override
//   _CancelSellOrderScreenState createState() => _CancelSellOrderScreenState();
// }

// class _CancelSellOrderScreenState extends State<CancelSellOrderScreen> {
//   final ControllerRepairCancelReasonList controllerSellCancelReason =
//       Get.put(ControllerRepairCancelReasonList());

//   String? selectedReasonId;
//   TextEditingController otherReasonController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     controllerSellCancelReason.getRepairCancelReasonData();
//   }

//   void _showCancelDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 decoration: BoxDecoration(
//                   color: ColorConstants.appBlueColor3,
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Do you really want to cancel?',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed: () => Navigator.pop(context),
//                             style: OutlinedButton.styleFrom(
//                               side: BorderSide(color: ColorConstants.appBlueColor3),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                             ),
//                             child: Text(
//                               'NO',
//                               style: TextStyle(
//                                 color: ColorConstants.appBlueColor3,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               Navigator.pop(context);

//                               final reasonText = controllerSellCancelReason.repairCancelReasonData?.table
//                                       .firstWhereOrNull((item) => item.id.toString() == selectedReasonId)
//                                       ?.reason ??
//                                   '';
//                               final enteredRemark = otherReasonController.text.trim();

//                               final result = await controllerSellCancelReason.cancelSellOrder(
//                                 orderId: widget.orderId,
//                                 customerId: widget.customerId,
//                                 reason: reasonText,
//                                 reasonId: selectedReasonId ?? '',
//                                 reasonRemark: enteredRemark,
//                               );

//                               if (result) {
//                                 Get.snackbar("Success", "Order cancelled successfully",
//                                     backgroundColor: Colors.green, colorText: Colors.white);
//                                 Navigator.pop(context, 'cancelled');
//                               } else {
//                                 Get.snackbar("Error", "Failed to cancel order",
//                                     backgroundColor: Colors.red, colorText: Colors.white);
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: ColorConstants.appBlueColor3,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                             ),
//                             child: const Text(
//                               'YES',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Reason for cancellation",
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(Icons.close, size: 24),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 18),
//               const Text("Please tell us the reason",
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 4),
//               Obx(() {
//                 if (controllerSellCancelReason.isSellCancelReasonLoading.value) {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       color: Colors.blue,
//                     ),
//                   );
//                 }
//                 // final sellCancelReasonDetails =
//                 //     controllerSellCancelReason.sellCancelReasonData?.table ?? [];
//                 return Column(
//                   children: sellCancelReasonDetails.map((item) {
//                     return RadioListTile<String>(
//                       value: item.id.toString(),
//                       groupValue: selectedReasonId,
//                       dense: true,
//                       visualDensity: const VisualDensity(vertical: -4),
//                       contentPadding: EdgeInsets.zero,
//                       title: Text(item.reason ?? '', style: const TextStyle(fontSize: 14)),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedReasonId = value;
//                         });
//                       },
//                       activeColor: ColorConstants.appBlueColor3,
//                     );
//                   }).toList(),
//                 );
//               }),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0, bottom: 20),
//                 child: TextField(
//                   controller: otherReasonController,
//                   decoration: const InputDecoration(
//                     hintText: "Tell us what we missed!",
//                     border: UnderlineInputBorder(),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (selectedReasonId == null &&
//                         otherReasonController.text.trim().isEmpty) {
//                       Get.snackbar(
//                         "Reason Required",
//                         "Please select or enter a cancellation reason.",
//                         backgroundColor: ColorConstants.appBlueColor3,
//                         colorText: Colors.white,
//                       );
//                       return;
//                     }
//                     _showCancelDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorConstants.appBlueColor3,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   child: const Text(
//                     "CONFIRM",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
