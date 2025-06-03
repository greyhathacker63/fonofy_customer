import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsColumn extends StatelessWidget {
  final String title;
  final String subtitle;
  final CrossAxisAlignment crossAxisAlignment;

  const StatsColumn({
    required this.title,
    required this.subtitle,
    this.crossAxisAlignment = CrossAxisAlignment.center, // default center
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)),
        SizedBox(height: 4),
        Text(subtitle, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
