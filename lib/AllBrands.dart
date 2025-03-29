import 'package:flutter/material.dart';
import 'package:fonofy/SelectProductScreen.dart';
import 'package:get/get.dart';
import 'SelectProductScreen3.dart'; 


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      debugShowCheckedModeBanner: false,
      home: AllBrandsScreen(),
    );
  }
}

class AllBrandsScreen extends StatelessWidget {
  final List<String> brands = [
    "Apple", "Xiaomi", "Samsung",
    "Vivo", "OnePlus", "Oppo",
    "Realme", "Motorola", "Lenovo",
    "Nokia", "Honor", "Google",
    "Poco", "Infinix", "Tecno",
    "IQOO", "Nothing"
  ];

  final String imagePath = "assets/images/phone.png"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Brands"),
        leading: const Icon(Icons.arrow_back),
        actions: const [Icon(Icons.search)],
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
              itemCount: brands.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => SelectProductScreen3()); 
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
                          brands[index],
                          style: const TextStyle(fontSize: 14),
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
