import 'package:flutter/material.dart';
import 'package:fonofy/Device/DeviceDetailsScreen2.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class DeviceDetailsScreen extends StatefulWidget {
  const DeviceDetailsScreen({Key? key}) : super(key: key);

  @override
  _DeviceDetailsScreenState createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  String? callStatus;
  String? touchStatus;
  String? screenStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tell us more about your device?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Please answer a few questions about your device.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 1),

            // Question 1
            _buildQuestion(
              "1. Are you able to make and receive calls?",
              "Check your device for cellular network connectivity issues.",
              (value) => setState(() => callStatus = value),
              callStatus,
            ),

            // Question 2
            _buildQuestion(
              "2. Is your device's touch screen working properly?",
              "Check the touch screen functionality of your phone.",
              (value) => setState(() => touchStatus = value),
              touchStatus,
            ),

            // Question 3
            _buildQuestion(
              "3. Is your phone's screen original?",
              "Pick 'Yes' if screen was never changed or was changed by an Authorized Service Center. Pick 'No' if screen was changed at a local shop.",
              (value) => setState(() => screenStatus = value),
              screenStatus,
            ),

            const SizedBox(height: 8),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.appBlueColor3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  if (callStatus != null && touchStatus != null && screenStatus != null) {
                    // Navigate to next screen (Modify as needed)
                    Get.to(() => DeviceDetailScreen2());
                  } else {
                    // Show error message if any question is unanswered
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please answer all questions.")),
                    );
                  }
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(
      String question, String description, Function(String?) onChanged, String? selectedValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text("Yes"),
                value: "Yes",
                groupValue: selectedValue,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text("No"),
                value: "No",
                groupValue: selectedValue,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
