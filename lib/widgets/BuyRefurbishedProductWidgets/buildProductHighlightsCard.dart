import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/ProductDetailsModel/ProductDetailsModel.dart';

Widget buildProductHighlightsCard(ProductDetailsModel product) {
  return Card(
    color: Colors.white,
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Product Highlights",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const Divider(),
          _buildProductHighlightRow(
              "Model", product.productAndModelName ?? ""),
          // _buildProductHighlightRow("Brand", "Realme"),
          _buildProductHighlightRow("RAM", product.ramName ?? ""),
          _buildProductHighlightRow("ROM", product.romName ?? ""),
          _buildProductHighlightRow("Battery", product.battery ?? ""),
          _buildProductHighlightRow("Color", product.colorName ?? ""),
          // _buildProductHighlightRow("OS", Platform.isAndroid?"android":"ios"),
          _buildProductHighlightRow("Rear Camera", product.rearCamera ?? ""),
          _buildProductHighlightRow("Front Camera", product.frontCamera ?? ""),
          _buildProductHighlightRow("Display", product.display ?? ""),
        ],
      ),
    ),
  );
}
Widget _buildProductHighlightRow(String title, String value) {
  return Padding(
    padding:   EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.black)),
      ],
    ),
  );
}

