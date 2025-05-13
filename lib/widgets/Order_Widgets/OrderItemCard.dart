import 'package:flutter/material.dart';
import 'package:fonofy/ViewScreen/Orders/OrderIdScreen.dart';
import 'package:get/get.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart'; // ✅ Make sure this is imported

class OrderItemCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderItemCard({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                      const Icon(Icons.broken_image, size: 60),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order ID: ${order['orderId']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 4),
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
                    Get.snackbar('Error', 'Customer ID not found');
                  }
                },
                child: const Text("View Orders"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
