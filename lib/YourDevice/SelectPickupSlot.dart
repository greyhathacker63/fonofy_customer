import 'package:flutter/material.dart';

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

  bool get isContinueEnabled =>
      selectedDate.value != null && selectedTimeSlot.value.isNotEmpty;
}

class PickupSlotPage extends StatelessWidget {
  final String shippingId;
  final String shippingName;
  final String shippingMobileNo;
  final String shippingEmailId;
  final String shippingAddress;
  final String shippingLandmark;
  final String shippingCity;
  final String shippingState;
  final String shippingPincode;
  final String workType;
  final String finalPrice;
  final String baseprice;
  final String pid;
  final String bid;
  final String raid;
  final String roid;
  final String selectedVariant;
  final String modelNo;
  final String ram;
  final String rom;
  final String modelName;
  final List finalhPageAns;

  const PickupSlotPage({
    super.key,
    required this.shippingId,
    required this.shippingName,
    required this.shippingMobileNo,
    required this.shippingEmailId,
    required this.shippingAddress,
    required this.shippingLandmark,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingPincode,
    required this.workType,
    required this.finalPrice,
    required this.baseprice,
    required this.pid,
    required this.bid,
    required this.raid,
    required this.roid,
    required this.selectedVariant,
    required this.modelNo,
    required this.ram,
    required this.rom,
    required this.modelName,
    required this.finalhPageAns,
  });

  @override
  Widget build(BuildContext context) {
    final PickupSlotController controller = Get.put(PickupSlotController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Your Device", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
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

            const SizedBox(height: 30),

            const Text("Please select your preferable pickup date",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            const SizedBox(height: 16),

            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: controller.nextDates.map((date) {
                    final isSelected = controller.selectedDate.value == date;
                    return GestureDetector(
                      onTap: () => controller.selectedDate.value = date,
                      child: Container(
                        width: 65,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorConstants.appBlueColor3
                              : Colors.grey.shade100,
                          border: Border.all(
                            color: isSelected
                                ? ColorConstants.appBlueColor3
                                : Colors.grey,
                          ),
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
                            Text(
                              DateFormat.EEEE().format(date).substring(0, 3),
                              style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      isSelected ? Colors.white : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )),

            const SizedBox(height: 30),

            const Text("Your availability on that day",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            const SizedBox(height: 16),

            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: controller.timeSlots.map((slot) {
                    final isSelected =
                        controller.selectedTimeSlot.value == slot;
                    return GestureDetector(
                      onTap: () => controller.selectedTimeSlot.value = slot,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorConstants.appBlueColor3.withOpacity(0.1)
                              : Colors.grey[100],
                          border: Border.all(
                              color: isSelected
                                  ? ColorConstants.appBlueColor3
                                  : Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          slot,
                          style: TextStyle(
                              color: isSelected
                                  ? ColorConstants.appBlueColor3
                                  : Colors.black),
                        ),
                      ),
                    );
                  }).toList(),
                )),

            const Spacer(),

            Row(
              children: [
                Text("₹$finalPrice",
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    // show price breakup modal
                  },
                  child: const Text("View Breakup",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isContinueEnabled
                        ? () {
                            Get.to(() => SelectPaymentMethodScreen(
                                  shippingId: shippingId,
                                  shippingName: shippingName,
                                  shippingMobileNo: shippingMobileNo,
                                  shippingEmailId: shippingEmailId,
                                  shippingAddress: shippingAddress,
                                  shippingLandmark: shippingLandmark,
                                  shippingCity: shippingCity,
                                  shippingState: shippingState,
                                  shippingPincode: shippingPincode,
                                  workType: workType,
                                  finalPrice: finalPrice,
                                  baseprice: baseprice,
                                  pid: pid,
                                  bid: bid,
                                  raid: raid,
                                  roid: roid,
                                  selectedVariant: selectedVariant,
                                  modelNo: modelNo,
                                  ram: ram,
                                  rom: rom,
                                  modelName: modelName,
                                  finalhPageAns: finalhPageAns,
                                  selectedDate: controller.selectedDate.value!,
                                  selectedTimeSlot:
                                      controller.selectedTimeSlot.value,
                                ));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isContinueEnabled
                          ? ColorConstants.appBlueColor3
                          : Colors.grey.shade400,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildStepBox(String number, String label, {bool isActive = false}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: isActive ? Colors.blue : Colors.grey,
          child: Text(number,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildDivider() {
    return Expanded(
      child: Container(height: 1, color: Colors.grey[400]),
    );
  }
}
