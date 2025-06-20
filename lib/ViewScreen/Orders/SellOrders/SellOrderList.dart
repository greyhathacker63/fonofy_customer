import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/controllers/OrderController/SellOrderController.dart';
import 'package:fonofy/utils/Colors.dart';

class SellOrderListScreen extends StatefulWidget {
  final String customerId;

  const SellOrderListScreen({super.key, required this.customerId});

  @override
  State<SellOrderListScreen> createState() => _SellOrderListScreenState();
}

class _SellOrderListScreenState extends State<SellOrderListScreen> {
  final SellOrderListController sellOrderListController = Get.put(SellOrderListController());

  @override
  void initState() {
    super.initState();
    sellOrderListController.fetchSellOrders(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Sell Orders List'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: Obx(() {
              if (sellOrderListController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue),
                );
              }

              if (sellOrderListController.sellOrdersList.isEmpty) {
                return const Center(child: Text('No orders found'));
              }

              return ListView.builder(
                itemCount: sellOrderListController.sellOrdersList.length,
                itemBuilder: (context, index) {
                  final order = sellOrderListController.sellOrdersList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          '$imageAllBaseUrl${order.image ?? ''}',
                          width: 60,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image, color: ColorConstants.appBlueColor3),
                        ),
                      ),
                      title: Text("Order ID: ${order.orderId ?? 'N/A'}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      subtitle: Text("Sell Date: ${order.createdDate ?? ''}",
                          style: const TextStyle(fontSize: 11)),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // TODO: Navigate to order detail screen
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
