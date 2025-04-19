import 'package:flutter/material.dart';
import 'package:fonofy/Device/DeviceDetailsScreen3.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class DeviceDetailScreen2 extends StatefulWidget {
  const DeviceDetailScreen2({Key? key}) : super(key: key);

  @override
  _DeviceDetailScreen2State createState() => _DeviceDetailScreen2State();
}

class _DeviceDetailScreen2State extends State<DeviceDetailScreen2> {
  // To track selected defects
  Map<String, bool> selectedDefects = {
    "broken_screen": false,
    "dead_spot": false,
    "scratch_body": false,
    "device_panel_broken": false,
  };

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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select screen/body defect that are applicable!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Please provide correct details."),
            const SizedBox(height: 16),
            
            // Grid of defect options
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
                children: [
                  buildDefectTile("broken_screen", "Broken/scratch on device screen", "assets/images/broken.png"),
                  buildDefectTile("dead_spot", "Dead Spot/Visible line and Discoloration", "assets/images/DeadSpot.png"),
                  buildDefectTile("scratch_body", "Scratch/Dent on device body", "assets/images/scratch.png"),
                  buildDefectTile("device_panel_broken", "Device panel missing/broken", "assets/images/DevicePanelMissing.png"),
                ],
              ),
            ),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.appBlueColor3, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                 Get.to(() => DeviceDetailsScreen3());
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

  // Widget for selectable defect option
  Widget buildDefectTile(String key, String label, String imagePath) {
    bool isSelected = selectedDefects[key] ?? false;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDefects[key] = !isSelected;
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
            Image.asset(imagePath, height: 80,width: 70,), // Image
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
