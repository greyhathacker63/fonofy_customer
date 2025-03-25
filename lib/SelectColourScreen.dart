import 'package:flutter/material.dart';

class SelectColourScreen extends StatelessWidget {
  // Sample data (Can be replaced with API data)
  final List<Map<String, String>> colors = [
    {"name": "Pink", "image": "assets/images/phone.png"},
    {"name": "Green", "image": "assets/images/phone.png"},
    {"name": "White", "image": "assets/images/phone.png"},
    {"name": "Yellow", "image": "assets/images/phone.png"},
    {"name": "Blue", "image": "assets/images/phone.png"},
  ];

  SelectColourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Select Color",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: colors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 items per row
                crossAxisSpacing: 1, // Border between columns
                mainAxisSpacing: 1, // Border between rows
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300), // Border around images
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        colors[index]["image"]!, // Load image from map
                        height: 60,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        colors[index]["name"]!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
