// import 'package:flutter/material.dart';
//
// import '../../model/ProductDetailsModel/ProductDetailsModel.dart';
//
// Widget buildPricingCard(ProductDetailsModel product) {
//   return Card(
//     elevation: 2,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//     child: Padding(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 10),
//           Row(
//             children: [
//               Text("-${product.discountPercentage?.toString() ?? ""}%",
//                   style: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold)),
//               const SizedBox(width: 10),
//               Text("₹${product.sellingPrice ?.toString() ?? ""}",
//                   style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black)),
//               const SizedBox(width: 8),
//               Text(
//                 "₹${product.newModelAmt?.toString() ?? ""}",
//                 style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                     decoration: TextDecoration.lineThrough,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 5),
//           const Text("View Plans",style: TextStyle(color: Colors.blue,fontSize: 14,fontWeight: FontWeight.bold)),
//           const SizedBox(height: 5),
//           const Text("Cardless and No Cost EMI Available on credit/debit card",
//               style: TextStyle(color: Colors.grey, fontSize: 12),
//           ),
//         ],
//       ),
//     ),
//   );
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/ProductDetailsModel/ProductDetailsModel.dart';

Widget buildPricingCard(ProductDetailsModel product) {
  double? getPriceBasedOnCondition() {
    if (product.romName == "Fair") {
      return product.sellingPrice;
    } else if (product.romName == "Good") {
      return product.sellingPriceF1;
    } else if (product.romName == "Superb") {
      return product.sellingPricePlus;
    }
    return product.sellingPrice;
  }

  // String condition = product.ramName ?? "Fair";
  // if (product.romName == "64GB" && condition != "Fair") {
  //   condition = "Fair";
  // } else if (product.romName == "128GB" && condition != "Good") {
  //   condition = "Good";
  // } else if (product.romName == "256GB" && condition != "Superb") {
  //   condition = "Superb";
  // }

  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Text("-${product.discountPercentage?.toString() ?? ""}%",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text("₹${getPriceBasedOnCondition()?.toString() ?? ""}",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(width: 8),
              Text(
                "₹${product.newModelAmt?.toString() ?? ""}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text("View Plans",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          const Text("Cardless and No Cost EMI Available on credit/debit card",
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    ),
  );
}