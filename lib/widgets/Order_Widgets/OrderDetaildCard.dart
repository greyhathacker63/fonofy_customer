import 'package:flutter/material.dart';
import 'package:fonofy/model/OrderModel/OrderProduct&DetailModel.dart';
import 'package:fonofy/widgets/ReviewDialogWidget.dart';

class OrderDetailsCard extends StatelessWidget {
  final OrderProductModel? product;
  final String status;
  final String orderId;
  final String customerId;

  const OrderDetailsCard({
    required this.product,
    required this.status,
    required this.orderId,
    required this.customerId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Center(child: Text("No product data"));
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  "http://cdn.fonofy.in${product!.productImage}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product!.productName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text("Quantity: ${product!.quantity}"),
                      Text("Price: ₹${product!.price}"),
                      Text("Status: $status"),
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
                      // Cancel logic
                    },
                    child: const Text("Cancel Order"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Get Invoice logic
                    },
                    child: const Text("Get Invoice"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ✅ Show "Add Review" only if status is "delivered"
            if (status.trim().toLowerCase() == "delivered")
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => ReviewDialog(
                        orderId: orderId,
                        productId: product!.productId,
                        colorId: product!.colorId,
                        ramId: product!.ramId,
                        romId: product!.romId,
                      ),
                    );
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.comment, color: Colors.grey),
                      SizedBox(width: 6),
                      Text("Add Review", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
