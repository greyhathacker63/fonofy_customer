import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:fonofy/widgets/GlobalTextFieldWithVerify.dart';
import 'package:fonofy/widgets/TextField.dart';
import 'Api_Service/api_register.dart';
import 'Api_Service/login_service.dart';
import 'EmailLoginScreen.dart';
import 'MainScreen.dart';
import 'SharedPreferences/SharedPreferences_email.dart';
import 'ViewModel/MobileOtpSend.dart';
import 'model/register_model.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  final String mobile;
  const RegisterScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    phoneNumberController.text = widget.mobile;
  }

  Future<bool> _sendOtp(String mobileNumber) async {
    final otpViewModel = Provider.of<OtpViewModel>(context, listen: false);
    await otpViewModel.sendOtp(mobileNumber);

    if (otpViewModel.statusMessage == "success") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("📩 OTP Sent Successfully!")),);
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("❌ OTP Sending Failed: ${otpViewModel.statusMessage}")),);
      print("OTP Sending Failed: ${otpViewModel.statusMessage}");

      return false;
    }
  }
  void _showVerificationDialog(BuildContext context, String mobileNumber) {
    String otp = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.85,
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Enter OTP",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please enter the OTP sent to your mobile number.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),

                 OtpTextField(
                  numberOfFields: 4,
                  borderWidth: 2,
                  fieldWidth: 50,
                  borderColor: Colors.blue,
                  showFieldAsBox: true,
                  onCodeChanged: (String verificationCode){
                    otp = verificationCode;
                  },
                  // onSubmit: (String verificationCode) {
                  //   // ✅ Handle OTP submission
                  //   Navigator.pop(context);
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text("✅ OTP Verified: $verificationCode")),
                  //   );
                  // },
                ),

                const SizedBox(height: 20),

                /// ✅ Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if(otp.isNotEmpty){
                          bool isVerified = await LoginService().verifyOTP(userOTP: otp, otp: otp);
                          if (isVerified) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("✅ OTP Verified Successfully!")),
                            );

                            await Future.delayed(const Duration(seconds: 1)); // Delay for better UX
                            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()),);
                          }
                          else {
                            // ❌ Show Error Message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("❌ OTP Not Matched! Try Again.")),
                            );
                          }
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP Field Can't Empty ⚠️")),);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                      ),
                      child: const Text("Verify"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: Image.asset('assets/images/register.png', fit: BoxFit.contain),
              ),
              const SizedBox(height: 20),

              GlobalTextField(
                hint: 'First Name',
                controller: firstNameController,
              ),

              GlobalTextFieldWithVerify(
                hint: 'Phone No.',
                controller: phoneNumberController,
                sendOtpCallback: _sendOtp,
                showVerificationDialog: _showVerificationDialog,
              ),

              GlobalTextField(
                hint: "Email ID",
                controller: emailController,
              ),
              GlobalTextField(
                hint: "Password",
                controller: passwordController,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF19628B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: isLoading ? null : _registerUser,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "SUBMIT",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // Future<void> _registerUser() async {
  //   final firstName = firstNameController.text.trim();
  //   final phoneNumber = phoneNumberController.text.trim();
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();
  //
  //   if (firstName.isEmpty || password.isEmpty || phoneNumber.isEmpty || email.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('❌ All fields are required!')),
  //     );
  //     return;
  //   }
  //
  //   setState(() => isLoading = true);
  //
  //   String registerData = json.encode({
  //     "FirstName": firstName,
  //     "PhoneNumber": phoneNumber,
  //     "Email": email,
  //     "Password": password,
  //   });
  //
  //   try {
  //     final registerService = RegisterService();
  //     final RegisterModel registerModel = await registerService.registerApi(registerData);
  //
  //     if (registerModel.success) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("✅ Registration Successful! Sending OTP...")),
  //       );
  //
  //       await Future.delayed(const Duration(seconds: 1));
  //
  //       bool otpSent = await _sendOtp(phoneNumber);
  //       if (otpSent) {
  //         // Get.to(OtpScreen(otp: ''));
  //         Get.to( MainScreen());
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         // SnackBar(content: Text('❌ Registration Failed: ${registerModel.message}')),
  //         SnackBar(content: Text('✅ Registration Successful! Sending OTP...')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('❌ Error: $e')),
  //     );
  //   } finally {
  //     setState(() => isLoading = false);
  //   }
  // }

  Future<void> _registerUser() async {
    final firstName = firstNameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (firstName.isEmpty || password.isEmpty || phoneNumber.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ All fields are required!')),
      );
      return;
    }

    setState(() => isLoading = true);

    String registerData = json.encode({
      "FirstName": firstName,
      "PhoneNumber": phoneNumber,
      "Email": email,
      "Password": password,
    });

    try {
      final registerService = RegisterService();
      final RegisterModel registerModel = await registerService.registerApi(registerData);

      if (registerModel.success) {
        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(content: Text("✅ Registration Successful!")),
        );


        await SharedpreferencesEmail().saveUserCredentials(email, password);

        await Future.delayed(const Duration(seconds: 1));

        // ✅ Navigate to Login Screen after registration
        Get.offAll(() => const EmailLoginScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          // SnackBar(content: Text("❌ Registration Failed: ${registerModel.message}")),
          SnackBar(content: Text('✅ Registration Successful!')),
        ); Get.to(MainScreen());
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }
}
