import 'package:flutter/material.dart';
import 'package:fonofy/Device/DeviceDetailsScreen4.dart';
import 'package:fonofy/widgets/ColorConstants/Colors.dart';
import 'package:get/get.dart';

class DeviceDetailsScreen3 extends StatefulWidget {
  @override
  _DeviceDetailsScreen3State createState() => _DeviceDetailsScreen3State();
}

class _DeviceDetailsScreen3State extends State<DeviceDetailsScreen3> {
  Map<String, bool> selectedIssues = {
    "front_camera": false,
    "back_camera": false,
    "volume_button": false,
    "finger_touch": false,
  };

  final List<Map<String, String>> issues = [
    {"key": "front_camera", "name": "Front Camera not working", "icon": "assets/images/front.png"},
    {"key": "back_camera", "name": "Back Camera not working", "icon": "assets/images/back.png"},
    {"key": "volume_button", "name": "Volume Button not working", "icon": "assets/images/volume.png"},
    {"key": "finger_touch", "name": "Finger touch not working", "icon": "assets/images/finger.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select the issue(s) applicable to your device!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Please select appropriate conditions."),
            const SizedBox(height: 16),
            
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
                children: issues.map((issue) {
                  return buildIssueTile(
                    issue["key"] ?? "", 
                    issue["name"] ?? "Unknown Issue", 
                    issue["icon"] ?? "assets/images/default.png"
                  );
                }).toList(),
              ),
            ),
           SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.appBlueColor3, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Get.to(() => DeviceDetailsScreen4());
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIssueTile(String key, String label, String imagePath) {
    bool isSelected = selectedIssues[key] ?? false;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIssues[key] = !isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 80,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: isSelected ? Colors.blue : Colors.grey[300],
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
