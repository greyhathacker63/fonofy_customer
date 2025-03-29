import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/SelectProductScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectProductScreen3(),
    );
  }
}

class SelectProductScreen3 extends StatelessWidget {
  final List<String> iphoneModels = [
    "Apple iPhone 6", "Apple iPhone 6 Plus",
    "Apple iPhone 7", "Apple iPhone 7 Plus",
    "Apple iPhone 8", "Apple iPhone 8 Plus",
    "Apple iPhone X", "Apple iPhone XR",
    "Apple iPhone XS", "Apple iPhone XS Max",
    "Apple iPhone 11"
  ];

  final String imagePath = "assets/images/phone.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your iPhone"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: iphoneModels.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 items per row
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to (() => SelectProductScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(imagePath, height: 50, width: 50, fit: BoxFit.cover),
                        const SizedBox(height: 5),
                        Text(
                          iphoneModels[index],
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
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