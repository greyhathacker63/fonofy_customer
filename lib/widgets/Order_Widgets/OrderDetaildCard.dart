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
    // Sort list by createdDate (DateTime?) ascending
    controller.trackingList.sort((a, b) {
      final dateA = a.createdDate;
      final dateB = b.createdDate;

      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return 1;
      if (dateB == null) return -1;
      return dateA.compareTo(dateB);
    });

    final latestData = controller.trackingList.last;

    Get.to(() => TrackOrdersScreen(
          orderId: widget.orderId,
          customerName: latestData.shippingName ?? "N/A",
          address: latestData.shippingAddress ?? "N/A",
          orderDate: latestData.createdDate != null
              ? latestData.createdDate!.toLocal().toString().split(' ')[0]
              : "N/A",
          status: latestData.orderStatus ?? "Pending",
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
                  // Always show Track Order if it's not empty or invalid
                  if ([
                    "pending",
                    "confirmed",
                    "dispatched",
                    "delivered",
                    "cancelled"
                  ].contains(widget.status.toLowerCase())) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: handleTrackOrder,
                        child: const Text("Track Order"),
                      ),
                    ),
                  ],

                  const SizedBox(width: 10),

                  // Show Cancel Order for pending and confirmed only
                  if (["pending", "confirmed"]
                      .contains(widget.status.toLowerCase())) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Cancel Order logic here
                        },
                        child: const Text("Cancel Order"),
                      ),
                    ),
                  ],

                  // Show Get Invoice for confirmed, dispatched, delivered, cancelled
                  if (["confirmed", "dispatched", "delivered", "cancelled"]
                      .contains(widget.status.toLowerCase())) ...[
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
