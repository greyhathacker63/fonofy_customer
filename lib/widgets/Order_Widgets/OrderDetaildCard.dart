import 'package:flutter/material.dart';

class OrderDetailsCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsCard({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                // Phone Image
                Image.asset('assets/images/phone.png', width: 80, height: 80, fit: BoxFit.cover),
                const SizedBox(width: 8),
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order['product'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("Configuration: ${order['size'] ?? ''}"),
                      Text("Price: ₹${order['price'] ?? ''}"),
                      Text("Status: ${order['status'] ?? ''}"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle cancel order
                    },
                    child: const Text("Cancel Order"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle get invoice
                    },
                    child: const Text("Get Invoice"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
