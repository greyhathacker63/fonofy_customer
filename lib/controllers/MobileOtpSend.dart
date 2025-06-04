import 'package:get/get.dart';
import 'package:fonofy/models/MobileOtpModel/MobileOtpModel.dart';
import '../Api_Service/mobileOtpService/MobileOtpSend.dart';

class OtpViewModel extends GetxController {
  final OtpService _otpService = OtpService();

  var isLoading = false.obs;
  var statusMessage = ''.obs;

  Future<void> sendOtp(String mobileNumber) async {
    isLoading.value = true;

    try {
      MobileOtpModel otpResponse = await _otpService.sendOtp(mobileNumber);

      if (otpResponse.status == "Otp Sent Succesfully.") {
        statusMessage.value = "success";
      } else {
        statusMessage.value = "OTP request failed";
      }
    } catch (e) {
      statusMessage.value = 'Failed to send OTP: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}