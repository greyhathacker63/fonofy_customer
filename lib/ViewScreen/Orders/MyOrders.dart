import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/controllers/OrderListController.dart';
import 'package:get/get.dart';

import 'package:fonofy/widgets/Order_Widgets/OrderItemCard.dart';

class MyOrdersScreen extends StatelessWidget {
  final OrderListController orderController = Get.put(OrderListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (orderController.orders.isEmpty) {
          return const Center(child: Text('No orders found'));
        }

        return ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return OrderItemCard(order: {
              'orderId': order.orderId,
              'createdDate': order.createdDate,
              'image': '${imageAllBaseUrl}${order.image}', 
            });
          },
        );
      }),
    );
  }
}
