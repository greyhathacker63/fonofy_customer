import 'package:flutter/material.dart';
import 'package:fonofy/model/RegisterModel/MobileOtp.dart';
import '../Api_Service/mobileOtpService/MobileOtpSend.dart';

class OtpViewModel extends ChangeNotifier {
  final OtpService _otpService = OtpService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _statusMessage = '';
  String get statusMessage => _statusMessage;


  Future<void> sendOtp(String mobileNumber) async {
    _isLoading = true;
    notifyListeners();

    try {
      MobileOtp otpResponse = await _otpService.sendOtp(mobileNumber);

      if (otpResponse.status == "Otp Sent Succesfully.") {
        _statusMessage = "success";
      } else {
        _statusMessage = "OTP request failed";
      }
    } catch (e) {
      _statusMessage = 'Failed to send OTP: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
