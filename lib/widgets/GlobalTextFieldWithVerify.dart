import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/MobileOtpSend.dart';

class GlobalTextFieldWithVerify extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Future<bool> Function(String) sendOtpCallback;
  final Function(BuildContext, String) showVerificationDialog;

  const GlobalTextFieldWithVerify({
    super.key,
    required this.hint,
    required this.controller,
    required this.sendOtpCallback,
    required this.showVerificationDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        maxLength: 10,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(),
          counterText: "", // Hide default character count
          suffixIcon: Consumer<OtpViewModel>(
            builder: (context, otpViewModel, child) {
              return TextButton(
                onPressed: () async {
                  if (controller.text.isEmpty || controller.text.length < 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("❌ Please enter a valid mobile number")),
                    );
                    return;
                  }

                  // ✅ Call OTP API
                  bool otpSent = await sendOtpCallback(controller.text);
                  if (otpSent) {
                    showVerificationDialog(context, controller.text);
                  }
                },
                child: otpViewModel.isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Verify",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
