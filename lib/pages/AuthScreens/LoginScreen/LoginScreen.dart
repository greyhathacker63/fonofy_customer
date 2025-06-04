import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/mobileOtpService/login_service.dart';
import 'package:fonofy/pages/AuthScreens/PhoneLoginScreen/PhoneLoginScreen.dart';
import 'package:fonofy/pages/AuthScreens/RegisterScreen/RegisterScreen.dart';
import 'package:get/get.dart';
import '../../../TokenHelper/TokenHelper.dart';
import '../../../controllers/MobileOtpSend.dart';
import '../OtpScreen/OtpScreen.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();
  var isLoading = false.obs;
  var statusMessage = ''.obs;
  final TextEditingController mobileNumberController = TextEditingController();

  Future<void> handleLogin() async {
    String mobileNumber = mobileNumberController.text.trim();

    if (mobileNumber.isEmpty) {
      showMessage('📢 Please enter a mobile number!');
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobileNumber)) {
      showMessage('❌ Please enter a valid 10-digit mobile number!');
      return;
    }

    isLoading.value = true;
    try {
      var response = await _loginService.checkMobileNumber(mobileNumber);

      if (response == null || !response.containsKey("IsActive")) {
        showMessage("❌ Unexpected server response. Try again later.");
        return;
      }

      bool isActive = response["IsActive"];
      String userCode = response["UserCode"] ?? "";

      if (isActive) {
        await TokenHelper.saveUserCode(userCode);
        var otpData = await _loginService.getOtp(mobileNumber);

        if (otpData['status'] == true) {
          showMessage("✅ OTP Sent Successfully!");
          await Future.delayed(const Duration(seconds: 1));
          Get.to(OtpScreen(otp: otpData['otp'], number: mobileNumber));
        } else {
          showMessage("❌ Failed to send OTP! Try again.");
        }
      } else {
        showMessage("🆕 This number is not registered. Redirecting...");
        await Future.delayed(const Duration(seconds: 1));
        Get.to(RegisterScreen(mobile: mobileNumber));
      }
    } catch (e) {
      showMessage("❌ Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void showMessage(String message) {
    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }
}

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              SizedBox(
                height: 100,
                child: Image.asset('assets/images/Logo.png',
                    fit: BoxFit.contain),
              ),
              const SizedBox(height: 20),
              // Login Image
              SizedBox(
                height: 40,
                child: Image.asset('assets/images/login.png',
                    fit: BoxFit.contain),
              ),
              const SizedBox(height: 20),

              // Mobile Number Field
              TextFormField(
                controller: controller.mobileNumberController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: "Mobile No.",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  counterText: "",
                  prefixText: '+91 ',
                  prefixStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Submit Button
              Obx(() => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF19628B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: controller.isLoading.value ? null : controller.handleLogin,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(
                          color: Colors.blue,
                          strokeWidth: 2,
                        )
                      : const Text(
                          "SUBMIT",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                ),
              )),
              // Success/Error Message
              Obx(() => controller.statusMessage.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        controller.statusMessage.value,
                        style: TextStyle(
                          color: controller.statusMessage.value ==
                                  'Otp Sent Successfully.'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    )
                  : SizedBox.shrink()),
              SizedBox(height: 20),

              // Signup / Email Login
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a member? "),
                      GestureDetector(
                        onTap: () {
                          Get.to(RegisterScreen(mobile: ''));
                        },
                        child: Text(
                          "Signup Now",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("or "),
                      GestureDetector(
                        onTap: () {
                          Get.to(PhoneLoginScreen());
                        },
                        child: const Text(
                          "Login with Phone",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}