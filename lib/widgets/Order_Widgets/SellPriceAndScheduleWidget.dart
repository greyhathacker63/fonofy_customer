// import 'package:flutter/material.dart';
// import 'package:fonofy/RepairScreen/ReapirOrderTrackingScreen.dart';
// import 'package:fonofy/ViewScreen/Orders/SellOrders/CancelSellOrderScreen.dart';
// import 'package:fonofy/controllers/OrderController/SellOrderDetailController.dart';
// import 'package:fonofy/utils/Colors.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SellPriceAndScheduleWidget extends StatelessWidget {
//   SellPriceAndScheduleWidget({super.key});

//   final SellOrderDetailController sellOrderDetailController =
//       Get.find<SellOrderDetailController>();

//   @override
//   Widget build(BuildContext context) {
//     final table1 = sellOrderDetailController.productDetail.value?? [];
//     final table = sellOrderDetailController.orderInfo.value?. [];

//     return Column(
//       children: [
//         if (table1.isNotEmpty)
//           Card(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Price Summary',
//                       style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
//                   const SizedBox(height: 6),
//                   Divider(thickness: 1, color: Colors.grey[300]),
//                   const SizedBox(height: 6),
//                   ListView.builder(
//                     itemCount: table1.length,
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       final item = table1[index];
//                       return Column(
//                         children: [
//                           _buildPriceRow(
//                             item.serviceName ?? '',
//                             '₹${(item.serviceAmount ?? 0).toStringAsFixed(2)}',
//                           ),
//                           _buildDashedLine(),
//                         ],
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 6),
//                   _buildPriceRow(
//                     'Total Amount',
//                     '₹${table1.fold<double>(0, (sum, item) => sum + (item.serviceAmount ?? 0)).toStringAsFixed(2)}',
//                     isBold: true,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         const SizedBox(height: 16),
//         if (table.isNotEmpty)
//           Card(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Address:',
//                       style: GoogleFonts.poppins(
//                           color: ColorConstants.appBlueColor3,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 4),
//                   Text(table.first.shippingAddress ?? '',
//                       style: GoogleFonts.poppins(fontSize: 12)),
//                   const SizedBox(height: 12),
//                   Text('Contact Number:',
//                       style: GoogleFonts.poppins(
//                           color: ColorConstants.appBlueColor3,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 4),
//                   Text(table.first.shippingMobileNo ?? '',
//                       style: GoogleFonts.poppins(fontSize: 13)),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: ColorConstants.appBlueColor3,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CancelSellOrderScreen(
//                                   orderId: table1.first.orderId ?? '',
//                                   customerId: table1.first.customerId ?? '',
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Text('CANCEL',
//                               style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w500)),
//                         ),
//                       ),
//                       const SizedBox(width: 13),
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: ColorConstants.appBlueColor3,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ReapirOrderTrackingScreen(),
//                               ),
//                             );
//                           },
//                           child: Text('Tracking',
//                               style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildPriceRow(String title, String amount, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title,
//               style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
//               )),
//           Text(amount,
//               style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildDashedLine() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final dashCount = (constraints.maxWidth / 6).floor();
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: List.generate(
//             dashCount,
//                 (_) => Container(width: 3, height: 1, color: Colors.grey[400]),
//           ),
//         );
//       },
//     );
//   }
// }
