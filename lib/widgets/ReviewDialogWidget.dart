import 'package:flutter/material.dart';
import 'package:fonofy/controllers/rating_controller.dart';

import 'package:fonofy/widgets/ColorConstants/Colors.dart';
import 'package:get/get.dart';

class ReviewDialog extends StatefulWidget {
  final int productId;
  final int colorId;
  final int ramId;
  final int romId;
  final String orderId;
  final Map<String, dynamic>? existingReview; 

  const ReviewDialog({
    required this.productId,
    required this.colorId,
    required this.ramId,
    required this.romId,
    required this.orderId,
    this.existingReview,
    super.key,
  });

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double rating = 0;
  final TextEditingController _controller = TextEditingController();
  final RatingController _ratingController = Get.put(RatingController());

  @override
  void initState() {
    super.initState();
    if (widget.existingReview != null) {
      rating = double.tryParse(widget.existingReview!['Rating']?.toString() ?? '0') ?? 0;
      _controller.text = widget.existingReview!['Description'] ?? '';
    }
  }

  void submitReview() async {
    if (rating == 0) {
      Get.snackbar("Rating Required", "Please select a rating before submitting.");
      return;
    }

    await _ratingController.submitRating(
      productId: widget.productId,
      orderId: widget.orderId,
      description: _controller.text,
      rating: rating.toInt(),
      colorId: widget.colorId,
      ramId: widget.ramId,
      romId: widget.romId,
    );

    Navigator.pop(context); // Close dialog after submission
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add Review Here",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),

            // Ratings Row
            Row(
              children: [
                const Text("Ratings:", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Row(
                  children: List.generate(
                    5,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          rating = index + 1;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Icon(
                          Icons.star,
                          size: 22,
                          color: index < rating ? Colors.orange : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Review Text Field
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Enter your review",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Submit Button
            Obx(() {
              return ElevatedButton(
                onPressed: _ratingController.isLoading.value ? null : submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.appBlueColor3,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: _ratingController.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Submit Review", style: TextStyle(color: Colors.white)),
              );
            }),
          ],
        ),
      ),
    );
  }
}
