import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/otp_response.dart';  // Import the OtpResponse model

class OtpViewModel extends ChangeNotifier {
  bool isLoading = false;
  String statusMessage = '';
  
  // Send OTP API function
  Future<void> sendOtp(String mobileNumber) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://api.fonofy.in/api/common/sendotp?mobileNumber=$mobileNumber');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // If the request is successful, parse the response
        OtpResponse otpResponse = OtpResponse.fromJson(jsonDecode(response.body));
        statusMessage = otpResponse.message;

        // Notify the listeners (UI)
        notifyListeners();
      } else {
        statusMessage = 'Failed to send OTP';
        notifyListeners();
      }
    } catch (error) {
      statusMessage = 'Error: $error';
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
