// import 'package:flutter/material.dart';
// import 'package:fonofy/controllers/RepairController/RepairOrderListController.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
// import '../utils/Colors.dart';
// import 'OrderRepairDetailsScreen.dart';
//
// class RepairOrderListScreen extends StatelessWidget {
//
//   final customerId ;
//     RepairOrderListScreen({super.key, this.customerId});
//
//   final RepairOrderListController repairOrderListController =Get.put(RepairOrderListController());
//
//     @override
//     void initState() {
//       super.initState();
//       repairOrderListController.getRepairOrdersList(widge);
//     }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text('Repair Orders List'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding:   EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//             child: Obx(() => Container(
//               padding:  EdgeInsets.all(10),
//
//             )),
//           ),
//
//
//           Obx(() => selectedType.value.isNotEmpty
//               ? Text(
//             "Selected Type: ${selectedType.value}",
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           )
//               : const SizedBox()),
//
//           const SizedBox(height: 20),
//
//           // 📦 Orders List
//           Expanded(
//             child: Obx(() {
//               if (orderController.isLoading.value) {
//                 return const Center(
//                   child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue),
//                 );
//               }
//               if (orderController.orders.isEmpty) {
//                 return const Center(child: Text('No orders found'));
//               }
//
//               return ListView.builder(
//                 itemCount: orderController.orders.length,
//                 itemBuilder: (context, index) {
//                   final order = orderController.orders[index];
//                   return OrderItemCard(order: {
//                     'orderId': order.orderId,
//                     'createdDate': order.createdDate,
//                     'image': '$imageAllBaseUrl${order.image}',
//                   });
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
//  }
