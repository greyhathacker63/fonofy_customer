import 'package:flutter/material.dart';
import 'package:fonofy/SelectProduct2.dart';
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
  final String imagePath = "assets/images/phone.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Product"),
        leading: const Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView( // Added scrollability
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card containing Image, Title, and Variant Selection
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image and Title
                      Row(
                        children: [
                          Image.asset(imagePath, height: 60, width: 60, fit: BoxFit.cover),
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
                                  style: TextStyle(fontSize: 14, color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Choose a Variant Title
                      const Text("Choose a variant", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),

                      // Variant Selection in Two Rows
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          variantOption("16 GB"),
                          variantOption("64 GB"),
                          variantOption("128 GB"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Price Disclaimer
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

              const SizedBox(height: 15),
              const Text("FAQs", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Divider(),
              faqItem("How did you calculate my device price?"),
              faqItem("Is it safe to sell my phone on Fonofy?"),
              faqItem("How does Voucher Payment work?"),
              const SizedBox(height: 10),

              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Load More FAQs", style: TextStyle(color: Colors.blue)),
                ),
              ),

              const SizedBox(height: 20), // Added spacing before the button

              // Bottom Button
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
      ),
    );
  }

  Widget variantOption(String variant) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedVariant = variant;
        });
      },
      child: Container(
        width: (MediaQuery.of(context).size.width / 2) - 30, // Two per row layout
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: selectedVariant == variant ? Colors.blue.shade100 : Colors.white,
        ),
        child: Row(
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
            Text(variant, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
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
