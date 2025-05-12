import 'package:flutter/material.dart';
import 'package:fonofy/widgets/Order_Widgets/OrderItemCard.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final List<Map<String, dynamic>> orders = List.generate(
    10, 
    (index) => {
      'image': 'https://via.placeholder.com/80',
      'orderId': 'AWS234TH',
      'product': 'iPhone 13',
      'ramRom': '4GB / 128GB',
      'price': '61999',
      'status': 'Delivered'
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderItemCard(order: orders[index]);
        },
      ),
    );
  }
}
  