
import 'package:flutter/material.dart';
import 'package:fonofy/widgets/Colors.dart';

void showPriceSummary(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Price Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildPriceRow("Base Price", "₹500"),
            _buildPriceRow("Pickup Charges", "Free", oldPrice: "₹100"),
            _buildPriceRow("Processing Fee", "-₹49", oldPrice: "₹100"),
            const Divider(),
            _buildPriceRow("Total Amount", "₹451", isBold: true),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:ColorConstants.appBlueColor3,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Sell Now", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}

Widget _buildPriceRow(String label, String price, {String? oldPrice, bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Row(
          children: [
            if (oldPrice != null)
              Text(
                oldPrice,
                style: const TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.lineThrough),
              ),
            const SizedBox(width: 5),
            Text(price, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ],
    ),
  );
}
