import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/RatingService/RatingService.dart';
import 'package:fonofy/ViewScreen/BuyRefurbishedProductScreen.dart';
import 'package:fonofy/ViewScreen/Orders/TrackOrdersScreen.dart';
import 'package:fonofy/controllers/OrderController/TrackOrderController.dart';
import 'package:fonofy/model/OrderModel/OrderProduct&DetailModel.dart';
import 'package:fonofy/widgets/ReviewDialogWidget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class OrderDetailsCard extends StatefulWidget {
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
  State<OrderDetailsCard> createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
  Map<String, dynamic>? reviewData;

  @override
  void initState() {
    super.initState();
    fetchReview();
  }

  Future<void> fetchReview() async {
    final data = await ProductRatingService.fetchProductRating(
      productId: widget.product!.productId,
      ramId: widget.product!.ramId,
      romId: widget.product!.romId,
      orderId: widget.orderId,
    );

    if (data != null) {
      setState(() {
        reviewData = data;
      });
    }
  }

  Future<void> handleTrackOrder() async {
    final controller = Get.put(TrackingController());

    await controller.fetchTrackingData(widget.orderId, widget.customerId);

    if (controller.trackingList.isNotEmpty) {
      final data = controller.trackingList.first;

      Get.to(() => TrackOrdersScreen(
            orderId: widget.orderId,
            customerName: data.shippingName ?? "N/A",
            address: data.shippingAddress ?? "N/A",
            orderDate: data.createdDate?.toLocal().toString().split(' ')[0] ?? "N/A",
            status: data.orderStatus ?? "Pending",
          ));
    } else {
      Get.snackbar("Error", "Unable to fetch tracking information");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return const Center(child: Text("No product data"));
    }

    return GestureDetector(
      onTap: () {
        // Navigate to BuyRefurbishedProductScreen (if needed)
      },
      behavior: HitTestBehavior.translucent,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image and product info
              Row(
                children: [
                  Image.network(
                    "http://cdn.fonofy.in${widget.product!.productImage}",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.image),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.product!.productName ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  if (widget.status.toLowerCase() == "pending" ||
                      widget.status.toLowerCase() == "confirmed") ...[
                    // Show Track Order button only
                    Expanded(
                      child: OutlinedButton(
                        onPressed: handleTrackOrder,
                        child: const Text("Track Order"),
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
                  ] else if (widget.status.toLowerCase() == "cancelled") ...[
                    // Only Get Invoice button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Get Invoice logic
                        },
                        child: const Text("Get Invoice"),
                      ),
                    ),
                  ] else ...[
                    // Default buttons (Cancel + Get Invoice)
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
                ],
              ),

              if (widget.status.trim().toLowerCase() == "delivered")
                IgnorePointer(
                  ignoring: false,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => ReviewDialog(
                            orderId: widget.orderId,
                            productId: widget.product!.productId,
                            colorId: widget.product!.colorId,
                            ramId: widget.product!.ramId,
                            romId: widget.product!.romId,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.comment, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            reviewData != null ? "Edit Review" : "Add Review",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
