import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ColorConstants/Colors.dart';

Widget byGrade({required List<Map<String, String>> grades}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "By Grade",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: grades.map((grade) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                  decoration: BoxDecoration(
                    color: grade['color'] == "blue"
                        ? ColorConstants.lightColor
                        : grade['color'] == "green"
                        ? ColorConstants.greenColor
                        : Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    grade['grade'] ?? '',
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}
