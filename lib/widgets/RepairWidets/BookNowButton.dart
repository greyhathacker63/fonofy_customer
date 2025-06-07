//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../model/table_banner_model/SelectProduct/SelectAddressScreen.dart';
// import '../../utils/Colors.dart';
//
// class BookNowButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final int totalPrice;
//
//   const BookNowButton({
//     super.key,
//     required this.onPressed,
//     required this.totalPrice,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isEnabled = onPressed != null;
//
//     return SizedBox(
//       width: double.infinity,
//       height: 70,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border(top: BorderSide(color: Colors.black12)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "₹$totalPrice",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "Apply Coupon",
//                   style: TextStyle(fontSize: 12, color: Colors.green),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isEnabled ? ColorConstants.appBlueColor3 : Colors.grey,
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               onPressed: isEnabled
//                   ? () {
//                 Get.to(() => SelectAddressScreen());
//               }
//                   : null,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 22),
//                     child: Text(
//                       "Book Now",
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Icon(Icons.arrow_forward, color: Colors.white, size: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controllers/RepairController/RepairServicesTableController.dart';
import '../../utils/Colors.dart';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/Colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/Colors.dart';

class BookNowButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final int totalPrice;

  const BookNowButton({
    super.key,
    required this.onPressed,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null && totalPrice > 0;

    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  final displayPrice = Get.find<RepairControllerTable>().totalPrice.value;
                  return Text(
                    displayPrice > 0 ? "₹$displayPrice" : "₹0",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  );
                }),
                const Text(
                  "Apply Coupon",
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isEnabled ? ColorConstants.appBlueColor3 : Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: isEnabled ? onPressed : null,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 22),
                    child: Text(
                      "Book Now",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}