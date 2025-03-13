import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: YourDeviceScreen2(),
    );
  }
}

class YourDeviceScreen2 extends StatelessWidget {
  const YourDeviceScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Your Device",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepBox("1", "Address", isActive: true),
                _buildDivider(),
                _buildStepBox("2", "Pickup Slot", isActive: false),
                _buildDivider(),
                _buildStepBox("3", "Payment", isActive: false),
              ],
            ),

            const SizedBox(height: 30),

            // Current Location Option
            Row(
              children: [
                Image.asset(
                  "assets/images/location.png", // Change to correct icon path
                  height: 30,
                ),
                const SizedBox(width: 10),
                const Text(
                  "Use My Current Location",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Pincode Input
            const Text(
              "Enter Pincode*",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 5),
            const TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),

            const Spacer(),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Navigate to next step
                },
                child: const Text("Continue", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Step Box UI
  Widget _buildStepBox(String number, String title, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.grey.shade300,
            border: Border.all(color: isActive ? Colors.blue : Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            number,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.blue : Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.black : Colors.black54,
          ),
        ),
      ],
    );
  }

  // Divider Line
  Widget _buildDivider() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey.shade300,
      ),
    );
  }
}
