import 'package:flutter/material.dart';
import 'package:fonofy/ViewScreen/bottom_navgation.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

void showThankYouDialog(BuildContext context, String name) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle,
                  color: ColorConstants.appBlueColor3, size: 60),
              const SizedBox(height: 16),
              Text(
                'Thank You, $name!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your booking was successful.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(BottomNavigation(
                      upperTabIndex:
                          0)); // Replace with your actual screen widget
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.appBlueColor3,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Back to Home',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    },
  );
}
