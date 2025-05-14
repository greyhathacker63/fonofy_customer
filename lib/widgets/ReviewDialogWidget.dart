import 'package:flutter/material.dart';
import 'package:fonofy/model/OrderModel/OrderProduct&DetailModel.dart';
import 'package:fonofy/utils/Colors.dart';

class ReviewDialog extends StatefulWidget {
  final String orderId;
  final String customerId;

  const ReviewDialog(
      {required this.orderId, required this.customerId, super.key});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double rating = 0;
  final TextEditingController _controller = TextEditingController();

  void submitReview() async {
    // Call your POST API here using widget.orderId, widget.customerId
    print('Submitting rating: $rating and review: ${_controller.text}');
    Navigator.pop(context); // Close popup after submission
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to left
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
                const Text(
                  "Ratings:",
                  style: TextStyle(fontSize: 16),
                ),
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
            ElevatedButton(
              onPressed: submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.appBlueColor3,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                "Submit Review",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
