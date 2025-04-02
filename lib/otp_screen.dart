import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fonofy/AllBrands.dart';
import 'package:fonofy/Api_Service/login_service.dart';
import 'package:fonofy/MainScreen.dart';
import 'package:http/http.dart' as http;

import 'Api_Service/TokenService.dart';
import 'TokenHelper/TokenHelper.dart';

class OtpScreen extends StatefulWidget {
  final String otp;
  final String number;
  const OtpScreen({super.key, required this.otp, required this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  TokenService tokenService = TokenService();

  Future<void> checkToken() async {
    String? token = await TokenHelper.getToken(); // Await the future
    if (token == null || token.isEmpty) {
      // print("Auth Token: $token");
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
            ElevatedButton(
              onPressed: () async {
                if (otpValue.isEmpty || otpValue.length < 4) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("❌ Please enter a 4-digit OTP")),
                  );
                  return;
                }
                bool isVerified = await LoginService().verifyOTP(userOTP: otpValue, otp: widget.otp, phoneNumber: widget.number);

                if (isVerified) {
                  String? token = await tokenService.generateToken(widget.number);
                    await TokenHelper.saveToken(token.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("✅ OTP Verified Successfully!")),
                  );

                  await Future.delayed(const Duration(seconds: 1)); // Delay for better UX
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => MainScreen()),
                  );
                }
                else {
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
