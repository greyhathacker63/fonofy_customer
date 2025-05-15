import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/RatingService/RatingService.dart';
import 'package:fonofy/ViewScreen/BuyRefurbishedProductScreen.dart';
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

  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return const Center(child: Text("No product data"));
    }

    return GestureDetector(
      onTap: () {
        // // Navigate to BuyRefurbishedScreen
        // Get.to(() => BuyRefurbishedProductScreen(
        //       productId: widget.product!.productId,
        //       ramId: widget.product!.ramId,
        //       romId: widget.product!.romId,
        //     ));
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product!.productName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text("Quantity: ${widget.product!.quantity}"),
                        Text("Price: ₹${widget.product!.price}"),
                        Text("Status: ${widget.status}"),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Buttons - Wrap in IgnorePointer
              Row(
                children: [
                  Expanded(
                    child: IgnorePointer(
                      ignoring: false,
                      child: OutlinedButton(
                        onPressed: () {
                          // Cancel logic
                        },
                        child: const Text("Cancel Order"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: IgnorePointer(
                      ignoring: false,
                      child: OutlinedButton(
                        onPressed: () {
                          // Get Invoice logic
                        },
                        child: const Text("Get Invoice"),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Add/Edit Review
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
                            // initialRating: reviewData?['Rating'],
                            // initialComment: reviewData?['Description'],
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