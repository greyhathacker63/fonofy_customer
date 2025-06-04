import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/ProductDetailsModel/ProductDetailsModel.dart';

Widget _buildPricingCard(ProductDetailsModel product) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 10,),
          Row(
            children: [
              Text("-${product.discountPercentage?.toString() ?? "0"}%",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text("₹${product.sellingPrice?.toString() ?? "0"}",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(width: 8),
              Text("₹${product.newModelAmt?.toString() ?? "0"}",
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough),
              ),

            ],

          ),

          const SizedBox(height: 5),
          const Text("View Plans",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          const Text(
              "Cardless and No Cost EMI Available on credit/debit card",
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    ),
  );
}