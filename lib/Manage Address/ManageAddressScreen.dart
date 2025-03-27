import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/Manage%20Address/AddNewAddressScreen.dart';

class ManageAddressScreen extends StatelessWidget {
  ManageAddressScreen({super.key});

  final List<Map<String, String>> addresses = [
    {
      "name": "Kuldeep Sharma",
      "workType": "Office",
      "address": "123, Andheri East, Mumbai",
      "state": "Maharashtra",
      "pincode": "400069",
      "mobile": "9876543210"
    },
    {
      "name": "Amit Verma",
      "workType": "Home",
      "address": "456, Whitefield, Bangalore",
      "state": "Karnataka",
      "pincode": "560066",
      "mobile": "9823456789"
    },
    {
      "name": "Neha Gupta",
      "workType": "Work",
      "address": "Connaught Place, New Delhi",
      "state": "Delhi",
      "pincode": "110001",
      "mobile": "9988776655"
    },
    {
      "name": "Rohit Mehta",
      "workType": "Home",
      "address": "952, Sector-13B, Rohini",
      "state": "Delhi",
      "pincode": "110026",
      "mobile": "9876501234"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Addresses"),
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
            ElevatedButton(
              onPressed: () {
                Get.to(() => AddNewAddressScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: const BorderSide(color: Colors.black),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  "+ Add New",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${address['name']}  |  ${address['workType']}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                address['address']!,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${address['state']} - ${address['pincode']}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Mobile: ${address['mobile']}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),

                        // Icons in Top-Right Corner
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  print("Edit Address ${address['city']}");
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.blueAccent),
                                onPressed: () {
                                  print("Delete Address ${address['city']}");
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
