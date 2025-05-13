import 'package:flutter/material.dart';
import 'package:fonofy/controllers/OrderDetailsController.dart';
import 'package:get/get.dart';
import 'package:fonofy/widgets/Order_Widgets/OrderDetaildCard.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final String customerId;
  final String deliveryDate;

  OrderDetailsScreen({
    required this.orderId,
    required this.customerId,
    required this.deliveryDate,
    super.key,
  });

  final controller = Get.put(OrderDetailController());

  @override
  Widget build(BuildContext context) {
    controller.loadOrderDetails(orderId, customerId);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            'Order Status: ${controller.orderDetail.value?.orderStatus ?? 'Loading...'}')),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final detail = controller.orderDetail.value;
        if (detail == null) return Center(child: Text("Order not found"));

        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderDetailsCard(
                product: controller.products.isNotEmpty
                    ? controller.products[0]
                    : null,
                status: detail.orderStatus,
              ),
              const Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Delivery Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(detail.ShippingName),
                    Text(detail.ShippingMobileNo),
                    Text(detail.ShippingEmailId),
                    Text(detail.shippingAddress),
                    const SizedBox(height: 20),
                    const Text("Expected Delivery Date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(deliveryDate), 
                    const SizedBox(height: 20),
                    const Text("Mode of Payment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(
                        "Card/UPI/COD/Net Banking"), // You can replace this later if payment info is added
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
