import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/RatingService/RatingService.dart';
import 'package:fonofy/pages/BuyRefurbishedProductScreen/BuyRefurbishedProductScreen.dart';
import 'package:fonofy/pages/TrackOrdersScreen/TrackOrdersScreen.dart';
import 'package:fonofy/controllers/OrderController/TrackOrderController.dart';
import 'package:fonofy/controllers/OrderDetailsController.dart';
import 'package:fonofy/models/OrderProductModel/OrderProductModel.dart';
import 'package:fonofy/widgets/ReviewDialogWidget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import '../../widgets/ColorConstants/Colors.dart';

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
  final OrderDetailController _orderController =
      Get.put(OrderDetailController());

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
      controller.trackingList.sort((a, b) {
        final dateA = a.createdDate;
        final dateB = b.createdDate;

        if (dateA == null && dateB == null) return 0;
        if (dateA == null) return 1;
        if (dateB == null) return -1;
        return dateA.compareTo(dateB);
      });

      final latestData = controller.trackingList.last;

      final String orderDateFormatted =
          latestData.createdDate?.toLocal().toString().split(' ')[0] ?? "N/A";
      final String confirmDateFormatted =
          latestData.confirmDate?.toLocal().toString().split(' ')[0] ?? "N/A";
      final String dispatchDateFormatted =
          latestData.dispatchDate?.toLocal().toString().split(' ')[0] ?? "N/A";

      Get.to(() => TrackOrdersScreen(
            orderId: widget.orderId,
            customerName: latestData.shippingName ?? "N/A",
            address: latestData.shippingAddress ?? "N/A",
            orderDate: orderDateFormatted,
            confirmDate: confirmDateFormatted,
            dispatchDate: dispatchDateFormatted,
            status: '',
          ));
    } else {
      Get.snackbar("Error", "Unable to fetch tracking information");
    }
  }

  void _showCancelDialog() {
    final TextEditingController _commentController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title:   Text('Cancel Order'),
          content: TextField(
            controller: _commentController,
            decoration:
                const InputDecoration(hintText: 'Enter cancellation reason'),
          ),
          actions: [
            // TextButton(
            //   onPressed: () => Navigator.pop(context),
            //   child:   Text('Close'),
            // ),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Close'),
            ),
            // TextButton(
            //   onPressed: () async {
            //     Navigator.pop(context);
            //     await _orderController.cancelOrder(
            //       widget.orderId,
            //       _commentController.text.trim(),
            //       widget.customerId,
            //     );
            //   },
            //   child: const Text('Confirm'),
            // ),
            OutlinedButton(
              onPressed: () async {
                Navigator.pop(context);
                await _orderController.cancelOrder(
                  widget.orderId,
                  _commentController.text.trim(),
                  widget.customerId,
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorConstants.appBlueColor3,
                side:   BorderSide(color: ColorConstants.appBlueColor3),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToProductDetails() {
    // TODO: Implement this navigation if needed
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => BuyRefurbishedProductScreen(
    //       url: widget.product!.url ?? '',
    //       refNo: widget.product!.refNo ?? '',
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return const Center(child: Text("No product data"));
    }

    return GestureDetector(
      onTap: _navigateToProductDetails,
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
              // Product Info
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

              const SizedBox(height: 25),

              // Action Buttons
              Row(
                children: [
                  if (["pending", "confirmed", "dispatched", "delivered", "cancelled"
                  ].contains(widget.status.toLowerCase())) ...[
                    // Expanded(
                    //   child: OutlinedButton(
                    //
                    //     onPressed: handleTrackOrder,
                    //     child:   Text("Track Order",style: TextStyle(fontSize: 16,color: ColorConstants.appBlueColor3),),
                    //   ),
                    // ),

                    Expanded(
                      child: OutlinedButton(
                        onPressed: handleTrackOrder,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ColorConstants.appBlueColor3, // text color
                          side: BorderSide(color: ColorConstants.appBlueColor3), // border color
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Track Order",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  ],
                    SizedBox(width: 10),
                  if (["pending", "confirmed"]
                      .contains(widget.status.toLowerCase())) ...[
                    // Expanded(
                    //   child: OutlinedButton(
                    //     onPressed: _showCancelDialog,
                    //     child: const Text("Cancel Order"),
                    //   ),
                    // ),

                    Expanded(
                      child: OutlinedButton(
                        onPressed: _showCancelDialog,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ColorConstants.appBlueColor3, // Text color
                          side: BorderSide(color: ColorConstants.appBlueColor3), // Border color
                          padding:   EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:   Text("Cancel Order",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                  ],
                  if (["confirmed", "dispatched", "delivered", "cancelled"]
                      .contains(widget.status.toLowerCase())) ...[
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Get invoice logic
                        },
                        child: const Text("Get Invoice"),
                      ),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 10),

              // Review Section
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
                            existingReview: reviewData,
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
