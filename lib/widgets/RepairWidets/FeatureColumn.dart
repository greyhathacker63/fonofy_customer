import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeatureColumn extends StatelessWidget {
  final IconData icon;
  final String label;

    const FeatureColumn({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Icon(icon, size: 28, color: Colors.blue),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
