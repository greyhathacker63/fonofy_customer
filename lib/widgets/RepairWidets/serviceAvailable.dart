import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget serviceAvailable() {
  List<Map<String, String>> services = [
    {"iconPath": "assets/images/screen.png", "serviceName": "Screen"},
    {"iconPath": "assets/images/batter.png", "serviceName": "Battery"},
    {"iconPath": "assets/images/mic.png", "serviceName": "Mic"},
    {"iconPath": "assets/images/receiver.png", "serviceName": "Receiver"},
  ];

  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("SERVICE AVAILABLE",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: services.map((service) {
            return Container(
              width: 80,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset(service["iconPath"]!,
                      height: 40), // Add your icons
                  const SizedBox(height: 8),
                  Text(
                    service["serviceName"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}