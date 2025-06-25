import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fonofy/Api_Service/mobileOtpService/login_service.dart';
import 'package:fonofy/ViewScreen/AccountsScreen.dart';
import 'package:fonofy/Api_Service/mobileOtpService/TokenService.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';

import '../utils/Colors.dart';

class OtpScreen extends StatefulWidget {
  final String otp;
  final String number;

  const OtpScreen({super.key, required this.otp, required this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TokenService tokenService = TokenService();

  bool isLoading = false;
  bool isOtpExpired = false;
  String otpValue = "";
  String currentOtp = "";
  int timerSeconds = 20;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    currentOtp = widget.otp;
    startTimer();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      timerSeconds = 20;
      isOtpExpired = false;
    });
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds > 0) {
        setState(() {
          timerSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          isOtpExpired = true;
        });
      }
    });
  }

  Future<void> _resendOtp() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("📩 Sending new OTP...")),
      );
      Map<String, dynamic> newOtpData = await LoginService().getOtp(widget.number);
      if (newOtpData['status']) {
        setState(() {
          currentOtp = newOtpData['otp'];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ New OTP Sent! Check your SMS.")),
        );
        startTimer();
      }
    } catch (e) {
      print("❌ Error resending OTP: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_sharp, size: 30.0, color: Colors.black),
            )
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
              ),
              const SizedBox(height: 20),
              const Text("OTP Verification",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text("Enter the code from the SMS we sent to +91 ${widget.number}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              OtpTextField(
                fieldWidth: 50,
                numberOfFields: 4,
                borderColor: ColorConstants.appBlueColor3,
                showFieldAsBox: true,
                onSubmit: (String verificationCode) {
                  setState(() {
                    otpValue = verificationCode;
                  });
                },
              ),

              SizedBox(height: 20),
              // SizedBox(
              //   width: double.infinity,
              //   height: 50.0,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: isOtpExpired ? Colors.grey : const Color(0xFF19628B),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //     ),
              //     onPressed: isLoading || isOtpExpired
              //         ? null
              //         : () async {
              //       if (otpValue.isEmpty || otpValue.length < 4) {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           const SnackBar(content: Text("❌ Please enter a 4-digit OTP")),
              //         );
              //         return;
              //       }
              //       setState(() {
              //         isLoading = true;
              //       });
              //       bool isVerified = await LoginService().verifyOTP(
              //         userOTP: otpValue,
              //         otp: currentOtp,
              //         phoneNumber: widget.number,
              //       );
              //
              //       if (isVerified) {
              //         String? token = await tokenService.generateToken(widget.number);
              //         await TokenHelper.saveToken(token.toString());
              //
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           const SnackBar(content: Text("✅ OTP Verified Successfully!"),backgroundColor: Colors.green,),
              //         );
              //
              //         await Future.delayed(const Duration(seconds: 1));
              //         Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => AccountScreen()),
              //         );
              //       } else {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(content: Text("❌ Invalid OTP! Please try again.")),
              //         );
              //       }
              //       setState(() {
              //         isLoading = false;
              //         Navigator.pop(context);
              //         Navigator.pop(context);
              //       });
              //     },
              //     child: isLoading
              //         ? const SizedBox(
              //       width: 24,
              //       height: 24,
              //       child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 2),
              //     )
              //         :   Text("Verify OTP",
              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              //     ),
              //   ),
              // ),

              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isOtpExpired ? Colors.grey : const Color(0xFF19628B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: isLoading || isOtpExpired
                      ? null
                      : () async {
                    if (otpValue.isEmpty || otpValue.length < 4) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("❌ Please enter a 4-digit OTP")),
                      );
                      return;
                    }

                    setState(() {
                      isLoading = true;
                    });
                    bool isVerified = await LoginService().verifyOTP(
                      userOTP: otpValue,
                      otp: currentOtp,
                      phoneNumber: widget.number,
                    );
                    if (isVerified) {
                      String? token = await tokenService.generateToken(widget.number);
                      await TokenHelper.saveToken(token.toString());

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("✅ OTP Verified Successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      await Future.delayed(Duration(seconds: 1));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountScreen(),));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("❌ Invalid OTP! Please try again.")),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: isLoading
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 2),
                  )
                      :  Text("Verify OTP",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )


              , SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(timerSeconds > 0
                        ? "OTP is valid upto $timerSeconds sec"
                        : "",
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  if (timerSeconds == 0)
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          timerSeconds = 20;
                        });
                        await _resendOtp();
                      },
                      child: Text("Resend OTP",style: TextStyle(fontSize: 14, color: ColorConstants.appBlueColor3),
                      ),
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


