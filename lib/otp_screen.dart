import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fonofy/AllBrands.dart';
import 'package:fonofy/Api_Service/login_service.dart';
import 'package:fonofy/MainScreen.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  final String otp;
  const OtpScreen({super.key, required this.otp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var otpValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter the OTP sent to your mobile number",
                style: TextStyle(fontSize: 16)),

            SizedBox(height: 20),

            OtpTextField(
              fieldWidth: 50,
              numberOfFields: 4,
              borderColor: Color(0xFF512DA8),
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              onSubmit: (String verificationCode) {
                otpValue = verificationCode;
                setState(() {});
              }, // end onSubmit
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

            // ElevatedButton(
            //   onPressed: () async {
            //     var isVerified = LoginService()
            //         .verifyOTP(userOTP: otpValue, otp: widget.otp);
            //     if (isVerified) {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (_) => AllBrandsScreen()));
            //     } else {
            //       ScaffoldMessenger.of(context)
            //           .showSnackBar(SnackBar(content: Text("OTP not matched")));
            //     }
            //   },
            //   child: Text("Verify OTP"),
            // ),
            ElevatedButton(
              onPressed: () async {
                if (otpValue.isEmpty || otpValue.length < 4) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("❌ Please enter a 4-digit OTP")),
                  );
                  return;
                }
                bool isVerified = await LoginService().verifyOTP(userOTP: otpValue, otp: widget.otp);

                if (isVerified) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("✅ OTP Verified Successfully!")),
                  );

                  await Future.delayed(const Duration(seconds: 1)); // Delay for better UX
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => MainScreen()),
                  );
                } else {
                  // ❌ Show Error Message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("❌ OTP Not Matched! Try Again.")),
                  );
                }
              },
              child: const Text("Verify OTP"),
            ),


          ],
        ),
      ),
    );
  }

  // This function will make an API call to verify the OTP

  // Future<bool> verifyOtp(
  //     String mobileNumber, String otp, BuildContext context) async {
  //   final url = Uri.parse(
  //       ' https://api.fonofy.in/api/common/sendotp?mobileNumber=9135609361'); // Replace with your actual API endpoint
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode({
  //         'mobileNumber': mobileNumber,
  //         'otp': otp,
  //       }),
  //       headers: {'Content-Type': 'application/json'},
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseBody = json.decode(response.body);
  //
  //       // Check if the response indicates OTP verification success
  //       if (responseBody['status'] == 'Verified') {
  //         return true; // OTP is valid
  //       } else {
  //         return false; // OTP is invalid
  //       }
  //     } else {
  //       // Handle server error (non-200 status)
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Failed to verify OTP. Please try again")),
  //       );
  //       return false;
  //     }
  //   } catch (e) {
  //     // Handle network or API error
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error: $e")),
  //     );
  //     return false;
  //   }
  // }
}
