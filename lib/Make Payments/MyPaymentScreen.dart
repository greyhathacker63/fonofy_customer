import 'package:flutter/material.dart';
import 'package:fonofy/widgets/Colors.dart';

class MyPaymentScreen extends StatelessWidget {
  MyPaymentScreen({super.key});

  // Dummy Voucher List (Replace with API Data)
  final List<Map<String, String>> vouchers = [
    {"title": "Fonofy Online Store Voucher"},
    {"title": "Unicorn Voucher"},
    {"title": "Fonofy Online Store Voucher"},
    {"title": "iPhone Voucher"},
    {"title": "Pickaboo Voucher"},
    {"title": "Salextra Voucher"},
    {"title": "Macbook Voucher"},
    {"title": "iPhone 16 Voucher"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Payments"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Voucher List
            Expanded(
              child: ListView.builder(
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  final voucher = vouchers[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Voucher Details
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                voucher["title"]!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Not Linked yet.",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),

                          // Add Button
                          ElevatedButton(
                            onPressed: () {
                              print("Add clicked for ${voucher["title"]}");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.appBlueColor3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text("Add +",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Wallet Section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "Wallet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
