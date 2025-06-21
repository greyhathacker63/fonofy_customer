// import 'package:flutter/material.dart';
//
//
// import '../../../controllers/RepairController/RepairCancelReasonListController.dart';
// import '../../../utils/Colors.dart';
//
//
// import 'package:get/get.dart';
//
// class CancelSellOrderScreen extends StatefulWidget {
//   @override
//   _CancelRepairOrderScreenState createState() => _CancelRepairOrderScreenState();
// }
//
// class _CancelRepairOrderScreenState extends State<CancelSellOrderScreen> {
//
//   final ControllerRepairCancelReasonList controllerRepairCancelReason = Get.put(ControllerRepairCancelReasonList());
//
//   String? selectedReasonId;
//
//   TextEditingController otherReasonController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     controllerRepairCancelReason.getRepairCancelReasonData();
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
//                 padding: EdgeInsets.symmetric(vertical: 14),
//                 decoration: BoxDecoration(
//                   color: ColorConstants.appBlueColor3,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                 ),
//                 child: Center(
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
//                     Text(
//                       'Do you really want to cancel?',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed: () => Navigator.pop(context),
//                             style: OutlinedButton.styleFrom(
//                               side: BorderSide(color: ColorConstants.appBlueColor3),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                               padding: EdgeInsets.symmetric(vertical: 12),
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
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               print('Cancelled with reason ID: $selectedReasonId');
//                               print('Other reason: ${otherReasonController.text}');
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: ColorConstants.appBlueColor3,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                               padding: EdgeInsets.symmetric(vertical: 12),
//                             ),
//                             child: Text('YES',
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
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Reason for cancellation",
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Icon(Icons.close, size: 24),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 18),
//                 Text("Please tell us the reason",
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 4),
//                 Obx(() {
//                   if (controllerRepairCancelReason.isRepairCancelReasonLoading.value) {
//                     return Center(child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,));
//                   }
//                   final repairCancelReasonDetails = controllerRepairCancelReason.repairCancelReasonData?.table1 ?? [];
//
//                   return Column(
//                     children: repairCancelReasonDetails.map((item) {
//                       return RadioListTile<String>(
//                         value: item.id.toString(),
//                         groupValue: selectedReasonId,
//                         dense: true,
//                         visualDensity: VisualDensity(vertical: -4),
//                         contentPadding: EdgeInsets.zero,
//                         title: Text(item.reason ?? '', style: TextStyle(fontSize: 14)),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedReasonId = value;
//                           });
//                         },
//                         activeColor: ColorConstants.appBlueColor3,
//                       );
//                     }).toList(),
//                   );
//                 }),
//                 Padding(
//                   padding: EdgeInsets.only(top: 8.0, bottom: 20),
//                   child: TextField(
//                     controller: otherReasonController,
//                     decoration: InputDecoration(
//                       hintText: "Tell us what we missed!",
//                       border: UnderlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _showCancelDialog,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ColorConstants.appBlueColor3,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     child: Text("CONFIRM",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, letterSpacing: 1,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//


import 'package:flutter/material.dart';

import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

import '../../../controllers/RepairController/RepairCancelReasonListController.dart';
import '../../../controllers/SellControllers/SellCancelOrderController.dart';

// class CancelSellOrderScreen extends StatefulWidget {
//   final String orderId;
//   final String customerId;
//
//   const CancelSellOrderScreen({
//     super.key,
//     required this.orderId,
//     required this.customerId,
//   });
//
//   @override
//   _CancelRepairOrderScreenState createState() => _CancelRepairOrderScreenState();
// }
//
// class _CancelRepairOrderScreenState extends State<CancelSellOrderScreen> {
//
//   final ControllerRepairCancelReasonList controllerRepairCancelReason = Get.put(ControllerRepairCancelReasonList());
//
//   final SellCancelOrderController cancelOrderController = Get.put(SellCancelOrderController());
//
//   String? selectedReasonId;
//
//   TextEditingController otherReasonController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     controllerRepairCancelReason.getRepairCancelReasonData();
//   }
//
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
//
//                               if (selectedReasonId == null) {
//                                 Get.snackbar("Error", "Please select a reason before confirming.",
//                                     backgroundColor: Colors.red, colorText: Colors.white);
//                                 return;
//                               }
//                               await cancelOrderController.cancelSellOrder(
//                                 orderId: widget.orderId,
//                                 customerId: widget.customerId,
//                                 reasone: otherReasonController.text,
//                                 reasonId: selectedReasonId!,
//                                 reasonRemark: otherReasonController.text,
//                               );
//
//                               if (cancelOrderController.cancelSellMessage.isNotEmpty) {
//                                 Navigator.pop(context); // Close the screen after cancel success
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
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text("Reason for cancellation",
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: const Icon(Icons.close, size: 24),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 18),
//                 const Text("Please tell us the reason",
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 4),
//                 Obx(() {
//                   if (controllerRepairCancelReason.isRepairCancelReasonLoading.value) {
//                     return const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue));
//                   }
//                   final repairCancelReasonDetails = controllerRepairCancelReason.repairCancelReasonData?.table1 ?? [];
//
//                   return Column(
//                     children: repairCancelReasonDetails.map((item) {
//                       return RadioListTile<String>(
//                         value: item.id.toString(),
//                         groupValue: selectedReasonId,
//                         dense: true,
//                         visualDensity: const VisualDensity(vertical: -4),
//                         contentPadding: EdgeInsets.zero,
//                         title: Text(item.reason ?? '', style: const TextStyle(fontSize: 14)),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedReasonId = value;
//                           });
//                         },
//                         activeColor: ColorConstants.appBlueColor3,
//                       );
//                     }).toList(),
//                   );
//                 }),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0, bottom: 20),
//                   child: TextField(
//                     controller: otherReasonController,
//                     decoration: const InputDecoration(
//                       hintText: "Tell us what we missed!",
//                       border: UnderlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _showCancelDialog,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ColorConstants.appBlueColor3,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     child: const Text(
//                       "CONFIRM",
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class CancelSellOrderScreen extends StatefulWidget {
  final String orderId;
  final String customerId;

  const CancelSellOrderScreen({
    super.key,
    required this.orderId,
    required this.customerId,
  });

  @override
  _CancelRepairOrderScreenState createState() => _CancelRepairOrderScreenState();
}

class _CancelRepairOrderScreenState extends State<CancelSellOrderScreen> {
  final ControllerRepairCancelReasonList controllerRepairCancelReason =
  Get.put(ControllerRepairCancelReasonList());

  final SellCancelOrderController cancelOrderController = Get.put(SellCancelOrderController());

  String? selectedReasonId;
  TextEditingController otherReasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerRepairCancelReason.getRepairCancelReasonData();
   }

  void _showCancelDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: ColorConstants.appBlueColor3,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: const Center(
                  child: Text('Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    const Text(
                      'Do you really want to cancel?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: ColorConstants.appBlueColor3),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'NO',
                              style: TextStyle(
                                color: ColorConstants.appBlueColor3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {

                              Navigator.pop(context);

                              if (selectedReasonId == null) {
                                Get.snackbar("Error", "Please select a reason before confirming.",
                                    backgroundColor: Colors.red, colorText: Colors.white);
                                return;
                              }

                              await cancelOrderController.cancelSellOrder(
                                orderId: widget.orderId,
                                customerId: widget.customerId,
                                reason: cancelOrderController.toString(),
                                reasonId: selectedReasonId!,
                                reasonRemark: otherReasonController.text,
                              );

                              if (cancelOrderController.cancelSellMessage.isNotEmpty) {
                                Navigator.pop(context); // Close the cancel screen
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.appBlueColor3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'YES',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Reason for cancellation",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, size: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text("Please tell us the reason",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Obx(() {
                  if (controllerRepairCancelReason.isRepairCancelReasonLoading.value) {
                    return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue));
                  }

                  final reasons = controllerRepairCancelReason.repairCancelReasonData?.table1 ?? [];

                  if (reasons.isEmpty) {
                    return const Text("No cancellation reasons available.");
                  }

                  return Column(
                    children: reasons.map((item) {
                      final itemId = item.id?.toString() ?? '';
                      final itemReason = item.reason ?? 'No Reason';

                      return RadioListTile<String>(
                        value: itemId,
                        groupValue: selectedReasonId,
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -4),
                        contentPadding: EdgeInsets.zero,
                        title: Text(itemReason, style: const TextStyle(fontSize: 14)),
                        onChanged: (value) {
                          setState(() {
                            selectedReasonId = value;
                          });
                        },
                        activeColor: ColorConstants.appBlueColor3,
                      );
                    }).toList(),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                  child: TextField(
                    controller: otherReasonController,
                    decoration: const InputDecoration(
                      hintText: "Tell us what we missed!",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _showCancelDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.appBlueColor3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "CONFIRM",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


