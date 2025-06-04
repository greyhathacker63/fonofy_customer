import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/pages/OrderDetailsScreen/OrderDetailsScreen.dart';
import 'package:fonofy/controllers/OrderListController.dart';
import 'package:get/get.dart';

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({super.key});
  final OrderListController orderController = Get.put(OrderListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.blue,
          ));
        }

        if (orderController.orders.isEmpty) {
          return const Center(child: Text('No orders found'));
        }
        return ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return OrderDetailsScreen(
              orderId: order.orderId,
              deliveryDate: order.createdDate,
              customerId: '',
              // image: '${imageAllBaseUrl}${order.image}',
            );
          },
        );
      }),
    );
  }
}
