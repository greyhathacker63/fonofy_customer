import 'package:flutter/material.dart';

class RepairServiceScreen extends StatelessWidget {
  const RepairServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close Button (Top Right)
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // Logo and Heading (Logo Left, Text Right)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/repairservice.png", // Your logo path
                  height: 24, // Adjust logo size as needed
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    "Looking For Other Repair Service?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),
            const Text(
              "Please share details of your query & our team will get in touch with you with the best solution",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const SizedBox(height: 20),

            // Select Issue Type Title
            const Text(
              "Select your issue type:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Issue Type Text Fields (Not Buttons)
            _buildIssueTextField("IC Issue"),
            _buildIssueTextField("Motherboard Issues"),
            _buildIssueTextField("Dead Phone"),
            _buildIssueTextField("Camera Issues"),
            _buildIssueTextField("Volume Key FPC"),
            _buildIssueTextField("Power Key FPC"),

            const SizedBox(height: 20),

            // Pincode Input Field
            const Text(
              "Enter your pincode:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                hintText: "Eg : 120XXX",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            // Query Details Input Field
            const Text(
              "Details of query:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write here",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),

            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A89B3), // Matching screenshot
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Submit action
                },
                child: const Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to create Issue Type TextFields (Prefilled)
  Widget _buildIssueTextField(String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: placeholder, // Prefilled text that disappears when typing
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}
