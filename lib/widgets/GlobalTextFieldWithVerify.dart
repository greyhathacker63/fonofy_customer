import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/MobileOtpSend.dart';

// class GlobalTextFieldWithVerify extends StatelessWidget {
//   final String hint;
//   final TextEditingController controller;
//   final Future<bool> Function(String) sendOtpCallback;
//   final Function(BuildContext, String) showVerificationDialog;
//
//   const GlobalTextFieldWithVerify({
//     super.key,
//     required this.hint,
//     required this.controller,
//     required this.sendOtpCallback,
//     required this.showVerificationDialog,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15),
//       child: TextField(
//         controller: controller,
//         keyboardType: TextInputType.phone,
//         maxLength: 10,
//         decoration: InputDecoration(
//           labelText: hint,
//           border: OutlineInputBorder(),
//           counterText: "", // Hide default character count
//           suffixIcon: Consumer<OtpViewModel>(
//             builder: (context, otpViewModel, child) {
//               return TextButton(
//                 onPressed: () async {
//                   if (controller.text.isEmpty || controller.text.length < 10) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("❌ Please enter a valid mobile number")),
//                     );
//                     return;
//                   }
//
//                   // ✅ Call OTP API
//                   bool otpSent = await sendOtpCallback(controller.text);
//                   if (otpSent) {
//                     showVerificationDialog(context, controller.text);
//                   }
//                 },
//                 child: otpViewModel.isLoading
//                     ? const CircularProgressIndicator(strokeWidth: 1,color: Colors.blue,)
//                     : const Text("Verify", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

class GlobalTextFieldWithVerify extends StatefulWidget {
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
  State<GlobalTextFieldWithVerify> createState() =>
      _GlobalTextFieldWithVerifyState();
}

class _GlobalTextFieldWithVerifyState extends State<GlobalTextFieldWithVerify> {
  bool isOtpSentSuccess = false;
  bool isSending = false;

  @override
  void initState() {
    super.initState();
     widget.controller.addListener(() {
      if (isOtpSentSuccess && widget.controller.text.length != 10) {
        setState(() {
          isOtpSentSuccess = false;
        });
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.phone,
        maxLength: 10,
        decoration: InputDecoration(
          labelText: widget.hint,
          border: const OutlineInputBorder(),
          counterText: "",
          suffixIcon: Consumer<OtpViewModel>(
            builder: (context, otpViewModel, child) {
              return TextButton(
                onPressed: isSending || isOtpSentSuccess
                    ? null
                    : () async {
                        if (widget.controller.text.isEmpty ||
                            widget.controller.text.length < 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("❌ Please enter a valid mobile number"),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          isSending = true;
                          isOtpSentSuccess = false;
                        });

                        bool otpSent = await widget
                            .sendOtpCallback(widget.controller.text);

                        setState(() {
                          isSending = false;
                          isOtpSentSuccess = otpSent;
                        });

                        if (otpSent) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("✅ OTP sent successfully!"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          widget.showVerificationDialog(
                              context, widget.controller.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("❌ Failed to send OTP!"),
                            ),
                          );
                        }
                      },
                child: isSending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.blue),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          isOtpSentSuccess ? "✅" : "Verify",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
