import 'package:flutter/material.dart';
import 'package:fonofy/ManagePayments/MyPaymentsScreen.dart';
import 'package:fonofy/YourDevice/SelectPaymentMethodScreen.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PickupSlotController extends GetxController {
  var selectedDate = Rxn<DateTime>();
  var selectedTimeSlot = ''.obs;

  List<String> timeSlots = [
    '10:00 AM - 02:00 PM',
    '02:00 PM - 08:00 PM',
  ];

  List<DateTime> nextDates = List.generate(4, (index) {
    final now = DateTime.now();
    return now.add(Duration(days: index + 1));
  });

  // ✅ This enables the button only when both date and time are selected
  bool get isContinueEnabled =>
      selectedDate.value != null && selectedTimeSlot.value.isNotEmpty;
}

class PickupSlotPage extends StatelessWidget {
  final PickupSlotController controller = Get.put(PickupSlotController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Your Device", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Stepper
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStepBox("1", "Address"),
                    _buildDivider(),
                    _buildStepBox("2", "Pickup Slot", isActive: true),
                    _buildDivider(),
                    _buildStepBox("3", "Payment"),
                  ],
                ),

                SizedBox(height: 30),

                Text("Please select your preferable pickup date",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: controller.nextDates.map((date) {
                    bool isSelected = controller.selectedDate.value == date;
                    return GestureDetector(
                      onTap: () => controller.selectedDate.value = date,
                      child: Container(
                        width: 65,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorConstants.appBlueColor3
                              : Colors.grey.shade100,
                          border: Border.all(
                              color: isSelected
                                  ? ColorConstants.appBlueColor3
                                  : Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(DateFormat.d().format(date),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black)),
                            Text(DateFormat.EEEE().format(date).substring(0, 3),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 30),

                Text("Your availability on that day",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                SizedBox(height: 16),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.timeSlots.map((slot) {
                      bool selected = controller.selectedTimeSlot.value == slot;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0), // optional spacing
                        child: GestureDetector(
                          onTap: () => controller.selectedTimeSlot.value = slot,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: selected
                                  ? ColorConstants.appBlueColor3.withOpacity(0.1)
                                  : Colors.grey[100],
                              border: Border.all(
                                color: selected
                                    ? ColorConstants.appBlueColor3
                                    : Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              slot,
                              style: TextStyle(
                                color: selected
                                    ? ColorConstants.appBlueColor3
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Spacer(),

                Row(
                  children: [
                    Text("₹24,361",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        // Show price breakup
                      },
                      child: Text("View Breakup",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isContinueEnabled
                        ? () {
                            Get.to(() => SelectPaymentMethodScreen());
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isContinueEnabled
                          ? ColorConstants.appBlueColor3
                          : Colors.grey.shade400,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            )),
      ),
    );
  }

  Widget _buildStepBox(String number, String title, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.grey.shade300,
            border: Border.all(
              color: isActive ? Colors.blue : Colors.grey,
              width: 2,
            ),
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
        SizedBox(height: 5),
        Text(title,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.black : Colors.black54)),
      ],
    );
  }

  Widget _buildDivider() {
    return Expanded(
      child: Container(height: 2, color: Colors.grey.shade300),
    );
  }
}
