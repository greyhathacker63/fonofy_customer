import 'package:flutter/material.dart';

import '../utils/Colors.dart';

class RescheduleOrderRepairScreen extends StatefulWidget {
  const RescheduleOrderRepairScreen({super.key});

  @override
  _RescheduleOrderScreenState createState() => _RescheduleOrderScreenState();
}

class _RescheduleOrderScreenState extends State<RescheduleOrderRepairScreen> {
  String? selectedDate;
  String? selectedTime;
  String? selectedReason;

  final List<String> dateOptions = ['Jun 04 2025', 'Jun 05 2025', 'Jun 06 2025','Jun 07 2025','Jun 08 2025','Jun 09 2025'];
  final List<String> timeOptions = ['10:00 AM - 03:00 PM', '03:00 PM - 08:00 PM'];
  final List<String> reasonOptions = [
    'Not available at that time',
    'Out of town',
    'Address change',
    'Change time slot'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reschedule your order",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 24),
                  ),
                ],
              ),

              SizedBox(height: 30),

              Text(
                "Please select your suitable time",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              /// Date dropdown
              DropdownButtonFormField<String>(
                value: selectedDate,
                hint: Text("Select Date"),
                decoration: _dropdownDecoration(),
                items: dateOptions.map((date) {
                  return DropdownMenuItem(value: date, child: Text(date));
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedDate = value);
                },
              ),
              SizedBox(height: 20),

              /// Time dropdown
              DropdownButtonFormField<String>(
                value: selectedTime,
                hint: Text("Select Time"),
                decoration: _dropdownDecoration(),
                items: timeOptions.map((time) {
                  return DropdownMenuItem(value: time, child: Text(time));
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedTime = value);
                },
              ),

              SizedBox(height: 40),

              /// Reason section
              Text(
                "Please select a reason to reschedule your order:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              /// Reason dropdown
              DropdownButtonFormField<String>(
                value: selectedReason,
                hint: Text("Select Reason"),
                decoration: _dropdownDecoration(),
                items: reasonOptions.map((reason) {
                  return DropdownMenuItem(value: reason, child: Text(reason));
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedReason = value);
                },
              ),

              SizedBox(height: 24),

              /// Confirm button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedDate != null &&
                        selectedTime != null &&
                        selectedReason != null) {
                      print("Date: $selectedDate");
                      print("Time: $selectedTime");
                      print("Reason: $selectedReason");
                      // Add your logic here
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please select all fields."),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:ColorConstants.appBlueColor3, // green color
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    "CONFIRM",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }
}