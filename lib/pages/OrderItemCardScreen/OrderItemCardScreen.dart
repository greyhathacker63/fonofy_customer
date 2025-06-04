import 'package:flutter/material.dart';
import 'package:fonofy/pages/OrderDetailsScreen/OrderDetailsScreen.dart';
import 'package:get/get.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';

import '../../widgets/ColorConstants/Colors.dart';

class OrderItemCardScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderItemCardScreen({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:   EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding:   EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  order['image'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image, size: 60),
                ),
                  SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order ID: ${order['orderId']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                        SizedBox(height: 4),
                      Text("Date: ${order['createdDate']}",
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              // child: ElevatedButton(
              //   onPressed: () async {
              //     final customerId = await TokenHelper.getUserCode();
              //     if (customerId != null) {
              //       Get.to(() => OrderDetailsScreen(
              //             orderId: order['orderId'],
              //             customerId: customerId,
              //             deliveryDate: order['createdDate'],
              //           ));
              //     } else {
              //       Get.snackbar('Error', 'Customer ID not found');
              //     }
              //   },
              //   child:   Text("View Orders"),
              // ),

              child: Padding(
                padding:   EdgeInsets.only(left: 200.0,top: 5 ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final customerId = await TokenHelper.getUserCode();
                      if (customerId != null) {
                        Get.to(() => OrderDetailsScreen(
                          orderId: order['orderId'],
                          customerId: customerId,
                          deliveryDate: order['createdDate'],
                        ));
                      } else {
                        Get.snackbar(
                          'Error',
                          'Customer ID not found',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(12),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.appBlueColor3,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "View Orders",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
