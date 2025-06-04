import 'package:flutter/material.dart';
import 'package:fonofy/controllers/OrderDetailsController.dart';
import 'package:get/get.dart';
import 'package:fonofy/pages/OrderDetailsCardScreen/OrderDetailsCardScreen.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  final String customerId;
  final String deliveryDate;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.customerId,
    required this.deliveryDate,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final controller = Get.put(OrderDetailController());

  @override
  void initState() {
    super.initState();
    controller.loadOrderDetails(widget.orderId, widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        title: Obx(() => Text(
              'Order Status: ${controller.orderDetail.value?.orderStatus ?? 'Loading...'}',
            )),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,));
        }

        final detail = controller.orderDetail.value;
        if (detail == null) return const Center(child: Text("Order not found"));

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
                orderId: widget.orderId,
                customerId: widget.customerId,
              ),
              const Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Delivery Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(detail.ShippingName),
                    Text(detail.ShippingMobileNo),
                    Text(detail.ShippingEmailId),
                    Text(detail.shippingAddress),
                    const SizedBox(height: 20),
                    const Text(
                      "Expected Delivery Date",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(widget.deliveryDate),
                    const SizedBox(height: 20),
                    const Text(
                      "Mode of Payment",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text("Card/UPI/COD/Net Banking"),
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
