import 'package:flutter/material.dart';
import 'package:fonofy/widgets/Order_Widgets/OrderDetaildCard.dart';


class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = {
      'orderId': 'HGTH67II',
      'product': 'Samsung Galaxy S21',
      'size': '8GB / 128GB',
      'price': '80599',
      'status': 'Order Placed',
      'name': 'Shawn Mendes',
      'phone': '+1 (101) 2345 7890',
      'address':
          'Champs de Mars at 5 Avenue Anatole France in the 7th arrondissement of Paris.',
      'deliveryDate': 'Monday | 16 October, 2023',
      'paymentMode': 'Card 99XX XXXX XXX XX23',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Order ID: ${order['orderId']}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderDetailsCard(order: order),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Delivery Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(order['name'] ?? ''),
                  Text(order['phone'] ?? ''),
                  Text(order['address'] ?? ''),
                  const SizedBox(height: 20),
                  const Text("Expected Delivery Date",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(order['deliveryDate'] ?? ''),
                  const SizedBox(height: 20),
                  const Text("Mode of Payment",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(order['paymentMode'] ?? ''),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
