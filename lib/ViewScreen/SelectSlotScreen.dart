import 'package:flutter/material.dart';
import 'package:fonofy/ViewScreen/CartScreen.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class SelectSlotScreen extends StatefulWidget {
  @override
  _SelectSlotScreenState createState() => _SelectSlotScreenState();
}

class _SelectSlotScreenState extends State<SelectSlotScreen> {
  String selectedDate = "22"; // Default selected date

  final List<Map<String, String>> dates = [
    {"label": "TODAY", "date": "21", "day": "Friday"},
    {"label": "TOMORROW", "date": "22", "day": "Saturday"},
    {"date": "23", "day": "Sunday"},
    {"date": "24", "day": "Monday"},
    {"date": "25", "day": "Tuesday"},
    {"date": "26", "day": "Wednesday"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Select Slot", style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // Stepper UI
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepBox("1", true),
              Container(
                width: Get.width * 0.55,
                height: 1.5,
                color: Colors.black26,
              ),
              _buildStepBox("2", true),
            ],
          ),
          const SizedBox(height: 5),

          // Step Labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Address",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Time Slot",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Date Selection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choose preferred date for repair expert to visit you",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: dates.map((date) {
                    bool isSelected = date["date"] == selectedDate;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = date["date"]!;
                        });
                      },
                      child: Container(
                        width: 80,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorConstants.appBlueColor3
                              : Colors.white,
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            if (date.containsKey("label"))
                              Text(
                                date["label"]!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            Text(
                              date["date"]!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              date["day"]!,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Bottom Price & Place Order Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white24,
              border: const Border(top: BorderSide(color: Colors.black12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("₹1,549",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("Show Price Breakup",
                        style: TextStyle(fontSize: 12, color: Colors.green)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appBlueColor3,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Get.to(() => CartScreen());
                  },
                  child: const Text("Place Order",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Step Box Widget
  Widget _buildStepBox(String step, bool isActive) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: isActive ? Colors.blue : Colors.black45),
        color: isActive ? Colors.white : Colors.black26,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Text(
        step,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.blue : Colors.white,
        ),
      ),
    );
  }
}
