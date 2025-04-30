import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Bottom_Sheet/ProductAttributeBottomSheet.dart';
import '../../model/ProductDetailsModel/ProductDetailsModel.dart';

Widget buildProductAttributesCard(BuildContext context, ProductDetailsModel product) {
  
  String condition = "Fair"; // default fallback
  if(product.romName == "64GB"){
    condition = "Fair";
  }else if(product.romName == "128GB"){
    condition = "Good";
  }else if(product.romName == "256GB"){
    condition = "Super";
  }
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(context: context, isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => ProductAttributeBottomSheet(product: product),
      );
    },
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildAttributeRow(Icons.phone_android, "Condition", "${condition}", "+1 more"),
            const Divider(),
            _buildAttributeRow(Icons.sd_storage, "Storage",
                "${product.ramName}/ ${product.romName}", "+2 more"),
            const Divider(),
            _buildAttributeRow(Icons.circle, "Color", "${product.colorName}", "+2 more",isColorDot: true),
          ],
        ),
      ),
    ),
  );
}

Widget _buildAttributeRow(
    IconData icon, String label, String value, String moreText,
    {bool isColorDot = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          if (isColorDot)
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            )
          else
            Icon(icon, size: 20),
          const SizedBox(width: 10),
          Text("$label: ", style: const TextStyle(fontSize: 14)),
          Text(value, style:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
      Text(moreText, style: const TextStyle(fontSize: 14, color: Colors.grey)),
    ],
  );
}
