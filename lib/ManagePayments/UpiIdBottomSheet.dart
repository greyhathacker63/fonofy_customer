import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/controllers/ManagePaymentController/UpiController.dart';
import 'package:fonofy/utils/Colors.dart';

class AddUpiBottomSheet extends StatefulWidget {
  final Function(String) onSubmit;

  const AddUpiBottomSheet({super.key, required this.onSubmit});

  @override
  State<AddUpiBottomSheet> createState() => _AddUpiBottomSheetState();
}

class _AddUpiBottomSheetState extends State<AddUpiBottomSheet> {
  final TextEditingController upiController = TextEditingController();
  final UpiController upiControllerInstance = Get.put(UpiController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Obx(
        () => AbsorbPointer(
          absorbing: upiControllerInstance.isLoading.value,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 50,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // Title and Close Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Existing UPI ID",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Get.back(); // ✅ Correct way to close bottom sheet
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // UPI Input Field
                TextField(
                  controller: upiController,
                  decoration: const InputDecoration(
                    hintText: "Enter your UPI ID",
                    border: UnderlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 15),
                  ),
                ),

                const SizedBox(height: 8),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "UPI ID is in the format of mobile@bank or username@bank.\nFind your UPI ID: Open UPI app > Tap Settings",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 16),

                // Lock Info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.lock, size: 16, color: Colors.black54),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Your account is encrypted and 100% safe with us.",
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      final upi = upiController.text.trim();
                      if (upi.isEmpty) return;

                      upiControllerInstance.isLoading.value = true;

                      await upiControllerInstance.submitUpi(upi);

                      upiControllerInstance.isLoading.value = false;

                      if (upiControllerInstance.upiId.value.isNotEmpty) {
                        widget.onSubmit(upi);
                        Get.back(); // ✅ Correctly closes bottom sheet

                        Future.microtask(() {
                          Get.snackbar(
                            "Success",
                            "UPI added successfully",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green.shade600,
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(12),
                            duration: const Duration(seconds: 2),
                          );
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.appBlueColor3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: upiControllerInstance.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Verify",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
