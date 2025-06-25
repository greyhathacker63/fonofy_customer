// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../controllers/RepairController/ControllerRepairOrderProductDetails.dart';
// import '../utils/Colors.dart';
//
// class ReapirOrderTrackingScreen extends StatefulWidget {
//   const ReapirOrderTrackingScreen({super.key});
//
//   @override
//   State<ReapirOrderTrackingScreen> createState() => _OrderTrackingScreenState();
// }
//
// class _OrderTrackingScreenState extends State<ReapirOrderTrackingScreen> {
//
//   final RepairOrderProductDetailsController repairOrderProductDetailsController = Get.find();
//
//   final List<TrackingStep> steps = [
//     TrackingStep('Order Confirmed', true,),
//     TrackingStep('Shipped', true),
//     TrackingStep('Out for Delivery', false),
//     TrackingStep('Delivered', false),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Repair Track Order",style: TextStyle(color: Colors.white),),
//         backgroundColor: ColorConstants.appBlueColor3,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding:   EdgeInsets.only(left: 20,top: 30),
//         child: Column(
//           children: [...steps.map((step) => buildStatusItem(step.title, step.isCompleted)),
//               SizedBox(height: 20),
//             _buildHelpCard(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildStatusItem(String title, bool isCompleted) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 1.0),
//       child: Row(
//         children: [
//           Column(
//             children: [
//               CircleAvatar(
//                 radius: 12,
//                 backgroundColor: isCompleted
//                     ? ColorConstants.appBlueColor3
//                     : Colors.grey[300],
//                 child: isCompleted
//                     ? Icon(Icons.check, size: 16, color: Colors.white)
//                     : null,
//               ),
//
//               if (title != steps.last.title)
//                 Container(width: 2, height: 40, color: Colors.grey[300]),
//             ],
//           ),
//           const SizedBox(width: 12),
//           Text(title, style: GoogleFonts.poppins(fontSize: 16)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHelpCard() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(6),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color:  ColorConstants.appBlueColor3,
//             ),
//             child: const Icon(
//               Icons.question_mark,
//               color: Colors.white,
//               size: 18,
//             ),
//           ),
//            SizedBox(width: 12),
//             Expanded(
//             child: Text("Have Some Query? Need Help?",
//               style: TextStyle(fontSize: 14),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class TrackingStep {
//   final String title;
//   final bool isCompleted;
//   TrackingStep(this.title, this.isCompleted);
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/RepairController/ControllerRepairOrderProductDetails.dart';
import '../utils/Colors.dart';
//
// class ReapirOrderTrackingScreen extends StatefulWidget {
//   const ReapirOrderTrackingScreen({super.key});
//
//   @override
//   State<ReapirOrderTrackingScreen> createState() => _OrderTrackingScreenState();
// }
//
// class _OrderTrackingScreenState extends State<ReapirOrderTrackingScreen> {
//   final RepairOrderProductDetailsController controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     final dataTable2 = controller.detailsRepairOrderProduct.value?.table2 ?? [];
//
//     List<TrackingStep> steps = [
//       TrackingStep('Order Placed', dataTable2[0].assignRemark=="Assign"?true:true),
//       TrackingStep('Agent Assigned', dataTable2[0].assignRemark=="Assign"?true:false),
//       TrackingStep('Order Confirmed', dataTable2[0].confirmRemark=="Assign"?true:false),
//       TrackingStep('Repair Complete', dataTable2[0].deliverRemark=="done"?true:false),
//     ];
//     // bool foundPending = false;
//     //
//     // for (var item in dataTable2) {
//     //   final title = item.orderStatus ?? '';
//     //   steps.add(TrackingStep(title, t));
//     // }
//     // if (foundPending) {
//     //   steps.addAll([
//     //     TrackingStep('Agent Assigned', false),
//     //     TrackingStep('Order Confirmed', false),
//     //     TrackingStep('Order Complete', false),
//     //   ]);
//     // } else {
//     //   steps.addAll([]);
//     // }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Repair Track Order",
//             style: TextStyle(color: Colors.white)),
//         backgroundColor: ColorConstants.appBlueColor3,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(left: 20, top: 60),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (steps.isEmpty) Center(child: Text("No tracking steps found.")),
//             for (int i = 0; i < steps.length; i++)
//               buildStatusItem(steps[i], i, steps.length),
//             const SizedBox(height: 20),
//             _buildHelpCard(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildStatusItem(TrackingStep step, int index, int totalSteps) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 1.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             children: [
//               CircleAvatar(
//                 radius: 12,
//                 backgroundColor: step.isCompleted
//                     ? ColorConstants.appBlueColor3
//                     : Colors.grey[300],
//                 child: step.isCompleted
//                     ? const Icon(Icons.check, size: 16, color: Colors.white)
//                     : null,
//               ),
//               if (index != totalSteps - 1)
//                 Container(width: 2, height: 40, color: Colors.grey[300]),
//             ],
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(step.title, style: GoogleFonts.poppins(fontSize: 16)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHelpCard() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(6),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: ColorConstants.appBlueColor3,
//             ),
//             child: const Icon(
//               Icons.question_mark,
//               color: Colors.white,
//               size: 18,
//             ),
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Text("Have Some Query? Need Help?",
//                 style: TextStyle(fontSize: 14)),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class TrackingStep {
//   final String title;
//   final bool isCompleted;
//
//   TrackingStep(this.title, this.isCompleted);
// }


class ReapirOrderTrackingScreen extends StatefulWidget {
  const ReapirOrderTrackingScreen({super.key});

  @override
  State<ReapirOrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<ReapirOrderTrackingScreen> {

  final RepairOrderProductDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final dataTable2 = controller.detailsRepairOrderProduct.value?.table2 ?? [];

    List<TrackingStep> steps = [];

    if (dataTable2.isNotEmpty) {
      String? status = dataTable2[0].orderStatus?.toLowerCase();

      if (status == "cancelled") {
        steps = [
          TrackingStep('Order Placed', true),
          TrackingStep('Cancelled', true),
        ];
      } else {
        steps = [
          TrackingStep('Order Placed', true),
          TrackingStep('Agent Assigned', status == "assigned" || status == "confirmed" || status == "delivered"),
          TrackingStep('Order Confirmed', status == "confirmed" || status == "delivered"),
          TrackingStep('Repair Complete', status == "delivered"),
        ];
      }
    }

    //  if (dataTable2.isNotEmpty) {
    //   String? status = dataTable2[0].orderStatus?.toLowerCase();
    //
    //   if (status == "cancelled") {
    //     steps = [
    //       TrackingStep('Order Placed', true),
    //       TrackingStep('Cancelled', true),
    //     ];
    //   } else {
    //     steps = [
    //       TrackingStep('Order Placed', true),
    //       TrackingStep('Agent Assigned', dataTable2[0].assignRemark == "${dataTable2[0].orderStatus}"),
    //       TrackingStep('Order Confirmed', dataTable2[0].confirmRemark == "${dataTable2[0].orderStatus}"),
    //       TrackingStep('Repair Complete', dataTable2[0].deliverRemark == "${dataTable2[0].orderStatus}"),
    //     ];
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Repair Track Order", style: TextStyle(color: Colors.white)),
        backgroundColor: ColorConstants.appBlueColor3,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding:   EdgeInsets.only(left: 20, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                children: [
                  Text(
                    "Current Status", style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),
                  ),
                  Text(" : - ",
                    style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.bold),
                  ),
                  Text("${dataTable2.isNotEmpty ? dataTable2[0].orderStatus : ''}",
                    style: GoogleFonts.poppins(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25,),
            if (steps.isEmpty)
                Center(child: Text("No tracking steps found.")),
            for (int i = 0; i < steps.length; i++)
              buildStatusItem(steps[i], i, steps.length),
            const SizedBox(height: 20),
            _buildHelpCard(),
          ],
        ),
      ),
    );
  }

  Widget buildStatusItem(TrackingStep step, int index, int totalSteps) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor:
                step.isCompleted ? ColorConstants.appBlueColor3 : Colors.grey[300],
                child: step.isCompleted
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
              if (index != totalSteps - 1)
                Container(width: 2, height: 40, color: Colors.grey[300]),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.title, style: GoogleFonts.poppins(fontSize: 16)),
                // if (step.date != null && step.date!.isNotEmpty)
                //   Text(step.date!,
                //     style: GoogleFonts.poppins(
                //       fontSize: 12,
                //       color: Colors.grey,
                //     ),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstants.appBlueColor3,
            ),
            child:   Icon(
              Icons.question_mark,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "Have Some Query? Need Help?",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class TrackingStep {
  final String title;
  final bool isCompleted;
  // final String? date;
  TrackingStep(this.title, this.isCompleted,);
}
