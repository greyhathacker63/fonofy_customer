import 'package:flutter/material.dart';
import 'package:fonofy/model/MobileOtp.dart';

import '../Api_Service/MobileOtpSend.dart';

class OtpViewModel extends ChangeNotifier {
  final OtpService _otpService = OtpService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _statusMessage = '';
  String get statusMessage => _statusMessage;

  // The function to send OTP
  Future<void> sendOtp(String mobileNumber) async {
    _isLoading = true;
    notifyListeners();
    try {
      MobileOtp otpResponse = await _otpService.sendOtp(mobileNumber);
      _statusMessage = otpResponse.status;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _statusMessage = 'Failed to send OTP: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }
}
