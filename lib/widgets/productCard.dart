import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget productCard({required String imagePath, required String label}) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
        ),
        child: Image.asset(imagePath, height: 80),
      ),
      const SizedBox(height: 5),
      Text(label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    ],
  );
}
