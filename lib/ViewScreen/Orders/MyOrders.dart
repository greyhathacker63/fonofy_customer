// import 'package:flutter/material.dart';
// import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
// import 'package:fonofy/controllers/OrderListController.dart';
// import 'package:get/get.dart';
//
// import 'package:fonofy/widgets/Order_Widgets/OrderItemCard.dart';
//
// class MyOrdersScreen extends StatelessWidget {
//
//   final OrderListController orderController = Get.put(OrderListController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:   Text('My Orders'),
//       ),
//       body: Obx(() {
//         if (orderController.isLoading.value) {
//           return   Center(child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,));
//         }
//         if (orderController.orders.isEmpty) {
//           return const Center(child: Text('No orders found'));
//         }
//         return ListView.builder(
//           itemCount: orderController.orders.length,
//           itemBuilder: (context, index) {
//             final order = orderController.orders[index];
//             return OrderItemCard(order: {
//               'orderId': order.orderId,
//               'createdDate': order.createdDate,
//               'image': '$imageAllBaseUrl${order.image}',
//             });
//           },
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/controllers/OrderListController.dart';
import 'package:fonofy/widgets/Order_Widgets/OrderItemCard.dart';
import 'package:get/get.dart';

import '../../RepairScreen/RepairOrderScreen.dart';
import '../../utils/Colors.dart';
import 'SellOrders/SellOrderList.dart';


class MyOrdersScreen extends StatelessWidget {

  final OrderListController orderController = Get.put(OrderListController());

  final RxString selectedType = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Column(
        children: [
          Padding(
            padding:   EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Obx(() => Container(
              padding:  EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildFilterButton("Buy"),
                  _buildFilterButton("Sell"),
                  _buildFilterButton("Repair"),
                ],
              ),
            )),
          ),


          Obx(() => selectedType.value.isNotEmpty
              ? Text("",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
              : const SizedBox()),

          const SizedBox(height: 20),

          // 📦 Orders List
          Expanded(
            child: Obx(() {
              if (orderController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue),
                );
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
                    'image': '$imageAllBaseUrl${order.image}',
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    final isSelected = selectedType.value == label;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? ColorConstants.appBlueColor3
            : ColorConstants.appBlueColor3.withOpacity(0.4),
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () async {
        selectedType.value = label;
        print("$label Clicked");

        final customerId = await TokenHelper.getUserCode(); // Get customer ID

        if (customerId == null || customerId.isEmpty) {
          print("Customer ID not found!");
          return;
        }
        if (label == "Repair") {
          Get.to(() => RepairOrderListScreen(customerId: customerId));
        } else if (label == "Sell") {
          Get.to(() => SellOrderListScreen(customerId: customerId));
        }
      },
      child: Text(label),
    );
  }
}



