import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> otpControllers = List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter the OTP sent to your mobile number", style: TextStyle(fontSize: 16)),

            SizedBox(height: 20),

            // OTP Input Fields (6 digit OTP)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 50,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: otpControllers[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: "", // Hide the counter
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Move to next TextField when value is entered
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            SizedBox(height: 20),

            // Submit Button
            // ElevatedButton(
            //   onPressed: () {
            //     String otp = otpControllers.map((controller) => controller.text).join();
            //     if (otp.length == 4) {
            //       print("Entered OTP: $otp");
            //       // Call an API for OTP verification (You can implement this part)
            //     } else {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text("Please enter a 4-digit OTP")),
            //       );
            //     }
            //   },
            //   child: Text("Verify OTP"),
            // ),

            ElevatedButton(
              onPressed: () async {
                // Get the OTP entered by the user
                String otp = otpControllers.map((controller) => controller.text).join();

                // Check if the OTP length is 4
                if (otp.length == 4) {
                  // Call the OTP verification API
                  String mobileNumber = "your_mobile_number_here";  // Replace with the actual mobile number passed during registration or login
                  bool isOtpValid = await verifyOtp(mobileNumber, otp, context);

                  if (isOtpValid) {
                    // OTP is valid, navigate to the next screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("OTP Verified Successfully")),
                    );
                    // Navigate to home or main screen after OTP verification
                    // Example:
                    // Get.to(MainScreen());
                  } else {
                    // OTP is invalid
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Invalid OTP. Please try again")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a 4-digit OTP")),
                  );
                }
              },
              child: Text("Verify OTP"),
            ),

          ],
        ),
      ),
    );
  }

  // This function will make an API call to verify the OTP

  Future<bool> verifyOtp(String mobileNumber, String otp, BuildContext context) async {
    final url = Uri.parse(' https://api.fonofy.in/api/common/sendotp?mobileNumber=9135609361'); // Replace with your actual API endpoint

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'mobileNumber': mobileNumber,
          'otp': otp,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        // Check if the response indicates OTP verification success
        if (responseBody['status'] == 'Verified') {
          return true; // OTP is valid
        } else {
          return false; // OTP is invalid
        }
      } else {
        // Handle server error (non-200 status)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to verify OTP. Please try again")),
        );
        return false;
      }
    } catch (e) {
      // Handle network or API error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return false;
    }
  }

}
