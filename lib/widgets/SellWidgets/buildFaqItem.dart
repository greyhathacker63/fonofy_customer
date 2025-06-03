import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildFaqItem(String question) {
  return Column(
    children: [
      ListTile(
        title: Text(question, style: const TextStyle(fontSize: 14)),
        trailing: const Icon(Icons.keyboard_arrow_down),
      ),
      const Divider(height: 1, color: Colors.grey),
    ],
  );
}
