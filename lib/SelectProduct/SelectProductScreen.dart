import 'package:flutter/material.dart';
import 'package:fonofy/SelectProduct/SelectProduct2.dart';
import 'package:fonofy/widgets/Colors.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectProductScreen(),
    );
  }
}

class SelectProductScreen extends StatefulWidget {
  @override
  _SelectProductScreenState createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  String? selectedVariant;

  final List<String> variants = ["16 GB", "64 GB", "128 GB"];
  final String imagePath = "assets/images/phone.png"; // Add this image to your assets folder.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Product"),
        leading: const Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Image.asset(imagePath, height: 50, width: 50, fit: BoxFit.cover),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Apple iPhone 6 Plus",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "7400+ already sold on Fonofy",
                            style: TextStyle(fontSize: 12, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text("Choose a variant", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: variants.map((variant) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedVariant = variant;
                    });
                  },
                  child: Container(
                    width: 106,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: selectedVariant == variant ? Colors.blue.shade100 : Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: variant,
                          groupValue: selectedVariant,
                          onChanged: (value) {
                            setState(() {
                              selectedVariant = value;
                            });
                          },
                        ),
                        Text(variant),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(8)),
              child: const Text(
                "The price stated above depends on the condition of the product and is not final. "
                "The final price offer will be quoted at the end of the diagnosis.",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            const Text("FAQs", style: TextStyle(fontSize: 2, fontWeight: FontWeight.bold)),
            const Divider(),
            faqItem("How did you calculate my device price?"),
            faqItem("Is it safe to sell my phone on Fonofy?"),
            faqItem("How does Voucher Payment work?"),
            const SizedBox(height: 1),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Load More FAQs", style: TextStyle(color: Colors.blue)),
              ),
            ),
            const Spacer(),
         SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      Get.to(() => SelectProduct2()); 
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorConstants.appBlueColor3, 
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
    child: const Text("Get Exact Value"),
  ),
),

          ],
        ),
      ),
    );
  }

  Widget faqItem(String question) {
    return Column(
      children: [
        ListTile(
          title: Text(question, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.keyboard_arrow_down),
        ),
        const Divider(),
      ],
    );
  }
}
