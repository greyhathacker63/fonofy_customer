import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controllers/ControllerProductDetails/DeliveryPinCodeController.dart';
import '../ColorConstants/Colors.dart';

Widget buildPincodeSection() {

  final TextEditingController pinController = TextEditingController();
  final DeliveryPinCodeController controllerDelivery = Get.put(DeliveryPinCodeController());

  return Card(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter Pincode for Delivery",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: pinController,
                  decoration: InputDecoration(
                    hintText: "Enter Pin code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    if (pinController.text.length == 6) {
                      controllerDelivery.fetchPinCode(pinController.text);
                    } else {
                      Get.snackbar("Invalid", "Please enter a valid 6-digit PIN code");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: ColorConstants.appBlueColor3, // You can change color if needed
                  ),
                  child: const Text("Check",style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              )

            ],
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (controllerDelivery.errorMessage.isNotEmpty) {
              return Text(
                controllerDelivery.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              );
            } else if (controllerDelivery.deliveryPinCodeModel.value != null) {
              final data = controllerDelivery.deliveryPinCodeModel.value!.deliveryCodes!;
              if (data.isNotEmpty && data[0].postalCode?.prePaid == "Y") {
                return Text(
                  "✅ Delivery Available",
                  style: const TextStyle(color: Colors.green),
                );
              } else {
                return const Text(
                  "Delivery not available for this PIN code.",
                  style: TextStyle(color: Colors.red),
                );
              }
            }
            return SizedBox();
          }),
        ],
      ),
    ),
  );
}
