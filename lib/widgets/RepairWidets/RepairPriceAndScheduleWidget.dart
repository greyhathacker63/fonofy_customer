import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../RepairScreen/CancelRepairOrderScreen.dart';
import '../../RepairScreen/ReapirOrderTrackingScreen.dart';
import '../../controllers/RepairController/ControllerRepairOrderProductDetails.dart';
import '../../controllers/RepairController/RepairOrderListController.dart';
import '../../utils/Colors.dart';

// class RepairPriceAndScheduleWidget extends StatelessWidget {
//   RepairPriceAndScheduleWidget({super.key});
//
//   // final RepairOrderProductDetailsController repairOrderProductDetailsController = Get.put(RepairOrderProductDetailsController());
//   final RepairOrderProductDetailsController repairOrderProductDetailsController = Get.find();
//
//
//   @override
//   Widget build(BuildContext context) {
//     final tableData1 = repairOrderProductDetailsController.detailsRepairOrderProduct.value?.table1 ?? [];
//      final tableData = repairOrderProductDetailsController.detailsRepairOrderProduct.value?.table ?? [];
//
//     return Column(
//       children: [
//         Card(
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12)),
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Price Summary',
//                   style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w600, fontSize: 16),
//                 ),
//                 SizedBox(height: 6),
//                 Divider(thickness: 1, color: Colors.grey[300]),
//                 const SizedBox(height: 6),
//                 _buildPriceRow('BATTERY', '₹2,999'),
//                 _buildDashedLine(),
//                 _buildPriceRow('SCREEN', '₹10,999'),
//                 _buildDashedLine(),
//                 _buildPriceRow('Total Amount', '₹13,998', isBold: true),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//
//         Card(
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12)),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                   SizedBox(height: 1),
//                 Text('Address:',
//                   style: GoogleFonts.poppins(
//                     color: ColorConstants.appBlueColor3,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'F-294, Sector 63, Noida, Uttar Pradesh, 201301',
//                   style: GoogleFonts.poppins(fontSize: 12),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   'Contact Number:',
//                   style: GoogleFonts.poppins(
//                     color: ColorConstants.appBlueColor3,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text('9554346561',
//                   style: GoogleFonts.poppins(fontSize: 13),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: ColorConstants.appBlueColor3,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) =>
//                                 CancelRepairOrderScreen(
//                                     orderId: '',
//                                     customerId: ''),
//                           )
//                           );
//                         },
//                         child: Text('CANCEL',
//                           style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 13),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: ColorConstants.appBlueColor3,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ReapirOrderTrackingScreen(),
//                             ),
//                           );
//                         },
//                         child: Text('Tracking',
//                           style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPriceRow(String title, String amount, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
//             ),
//           ),
//           Text(amount,
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDashedLine() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final dashCount = (constraints.maxWidth / 6).floor();
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: List.generate(
//             dashCount,
//                 (_) =>
//                 Container(
//                   width: 3,
//                   height: 1,
//                   color: Colors.grey[400],
//                 ),
//           ),
//         );
//       },
//     );
//   }
// }

class RepairPriceAndScheduleWidget extends StatelessWidget {
  RepairPriceAndScheduleWidget({super.key});

  final RepairOrderProductDetailsController repairOrderProductDetailsController = Get.put(RepairOrderProductDetailsController());

  @override
  Widget build(BuildContext context,) {
    final dataTable1 = repairOrderProductDetailsController.detailsRepairOrderProduct.value?.table1 ?? [];
    final dataTable = repairOrderProductDetailsController.detailsRepairOrderProduct.value?.table ?? [];

    return Column(
      children: [
        if (dataTable1.isNotEmpty)
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price Summary',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 6),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  const SizedBox(height: 6),
                  ListView.builder(
                    itemCount: dataTable1.length,
                    shrinkWrap: true,
                    physics:   NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final detailsTable1 = dataTable1[index];
                      return Column(
                        children: [
                          _buildPriceRow(
                            detailsTable1.serviceName ?? '', '₹${(detailsTable1.serviceAmount ?? 0).toStringAsFixed(2)}',
                          ),
                          _buildDashedLine(),

                        ],
                      );
                    },
                  ),

                  SizedBox(height: 6),
                  _buildPriceRow('Total Amount',
                    '₹${dataTable1.fold<double>(0, (sum, item) => sum + (item.serviceAmount ?? 0)).toStringAsFixed(2)}',
                    isBold: true,
                  ),
                ],
              ),
            ),
          ),

        SizedBox(height: 16),
        if (dataTable.isNotEmpty)
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address:',style: GoogleFonts.poppins(
                      color: ColorConstants.appBlueColor3, fontSize: 14,
                      fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(dataTable.first.shippingAddress ?? '', style: GoogleFonts.poppins(fontSize: 12)),
                  const SizedBox(height: 12),
                  Text('Contact Number:',
                      style: GoogleFonts.poppins(
                          color: ColorConstants.appBlueColor3,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(dataTable.first.shippingMobileNo ?? '',
                      style: GoogleFonts.poppins(fontSize: 13)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.appBlueColor3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) => CancelRepairOrderScreen(orderId: dataTable1.first.orderId ?? '', customerId: dataTable1.first.customerId ?? '',
                                ),
                              ),
                            );
                          },
                          child: Text('CANCEL',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.appBlueColor3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReapirOrderTrackingScreen(),
                              ),
                            );
                          },
                          child: Text('Tracking',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPriceRow(String title, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
              )),
          Text(amount,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
              )),
        ],
      ),
    );
  }

  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount = (constraints.maxWidth / 6).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            dashCount,
                (_) => Container(width: 3, height: 1, color: Colors.grey[400]),
          ),
        );
      },
    );
  }}

