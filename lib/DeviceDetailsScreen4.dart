import 'package:flutter/material.dart';
import 'package:fonofy/YourDevice.dart';
import 'package:fonofy/widgets/Colors.dart';
import 'package:get/get.dart';

class DeviceDetailsScreen4 extends StatefulWidget {
  const DeviceDetailsScreen4({super.key});

  @override
  State<DeviceDetailsScreen4> createState() => _DeviceDetailsScreen4State();
}

class _DeviceDetailsScreen4State extends State<DeviceDetailsScreen4> {
  bool isChargerSelected = false;
  bool isBoxSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:
            const Text("Device Details", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Do you have the following?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Please select accessories which are available",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),

            // Accessories Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAccessoryCard(
                  "assets/images/charger.png",
                  "Original charger of device",
                  isChargerSelected,
                  () {
                    setState(() {
                      isChargerSelected = !isChargerSelected;
                    });
                  },
                ),
                const SizedBox(width: 16),
                _buildAccessoryCard(
                  "assets/images/boximei.png",
                  "Box with same IMEI",
                  isBoxSelected,
                  () {
                    setState(() {
                      isBoxSelected = !isBoxSelected;
                    });
                  },
                ),
              ],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (isChargerSelected || isBoxSelected)
                    ? () {
                        Get.to(() => YourDeviceScreen());
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.appBlueColor3,
                  disabledBackgroundColor: ColorConstants.appBlueColor3,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessoryCard(
      String imagePath, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 160,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: isSelected ? Colors.blueGrey : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 100),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
