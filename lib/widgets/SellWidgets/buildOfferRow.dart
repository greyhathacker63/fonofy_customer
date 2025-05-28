import 'package:flutter/cupertino.dart';

Widget buildOfferRow(String iconPath, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Image.asset(iconPath, height: 20), // Replace with actual icon
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    ),
  );
}

