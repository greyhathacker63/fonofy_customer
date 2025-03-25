// import 'package:flutter/material.dart';
// import 'package:fonofy/Api_Service/MobileOtpSend.dart';
// import 'package:fonofy/Api_Service/login_service.dart';
// import 'package:fonofy/EmailLoginScreen.dart';
// import 'package:fonofy/MainScreen.dart';
// import 'package:fonofy/RegisterScreen.dart';
// import 'package:fonofy/bottom_navgation.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
//
// import 'ViewModel/MobileOtpSend.dart';
// import 'otp_screen.dart';
//
// class LoginScreen extends StatelessWidget {
//   final TextEditingController mobileNumberController = TextEditingController();
//   // final TextEditingController otpNumberController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     int status = 0;
//     final String otp;
//     return Scaffold(
//       backgroundColor: Colors.white, // Setting the background color to white
//       body:  ChangeNotifierProvider(
//         create: (_) => OtpViewModel(),
//         child: Consumer<OtpViewModel>(
//           builder: (context, viewModel, child) {
//             return Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Logo Section
//                     SizedBox(
//                       height: 100, // Adjust height as per your logo
//                       child: Image.asset(
//                         'assets/images/Logo.png', // Replace with your logo path
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // Login Image (Replaces "LOGIN" text & icon)
//                     SizedBox(
//                       height: 40, // Adjust height as needed
//                       child: Image.asset(
//                         'assets/images/login.png',
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // Mobile Number Input Field
//                     TextField(
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         labelText: "Mobile No.",
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.phone),
//                       ),
//                       controller: mobileNumberController,
//                     ),
//                     const SizedBox(height: 15),
//
//                     // OTP Input Field
//
//                     // TextField(
//                     //   keyboardType: TextInputType.number,
//                     //   decoration: InputDecoration(
//                     //     labelText: "Enter OTP",
//                     //     border: OutlineInputBorder(),
//                     //     prefixIcon: Icon(Icons.lock),
//                     //   ),
//                     //   controller: otpNumberController,
//                     // ),
//                     const SizedBox(height: 20),
//
//                     // Submit Button - Navigate to RegisterScreen
//                     viewModel.isLoading? CircularProgressIndicator():
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF19628B), // Button color
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                         ),
//                         // onPressed: () async{
//                         //   var isAvailable = await LoginService().checkMobileNumber(mobileNumberController.text.trim());
//                         //   if(isAvailable){
//                         //     var data = await LoginService().getOtp(mobileNumberController.text.trim());
//                         //     if(data['status'] == true){
//                         //       Navigator.push(context, MaterialPageRoute(builder: (_)=>OtpScreen(otp:data['otp'])));
//                         //     }else{
//                         //       Navigator.push(context, MaterialPageRoute(builder: (_)=>RegisterScreen(mobile: mobileNumberController.text.trim(),)));
//                         //     }
//                         //
//                         //   }else{
//                         //     Navigator.push(context, MaterialPageRoute(builder: (_)=>RegisterScreen(mobile: mobileNumberController.text.trim(),)));
//                         //   }
//                         //
//                         //   // if(status == 0){
//                         //   //   if(mobileNumberController.text.toString().isNotEmpty){
//                         //   //     final mobileNumber = mobileNumberController.text;
//                         //   //     viewModel.sendOtp(mobileNumber);
//                         //   //     if(viewModel.statusMessage == "Otp Sent Succesfully."){
//                         //   //       status = 1;
//                         //   //     }
//                         //   //
//                         //   //   }else{
//                         //   //     ScaffoldMessenger.of(context).showSnackBar(
//                         //   //         SnackBar(content: Text('Mobile Number Can not Empty...'), duration: Duration(seconds: 2),)
//                         //   //     );
//                         //   //   }
//                         //   // }else{
//                         //   //   if(otpNumberController.text.toString().isNotEmpty){
//                         //   //     final mobileNumber = otpNumberController.text;
//                         //   //     viewModel.sendOtp(mobileNumber);
//                         //   //     if(viewModel.statusMessage == "Otp Sent Succesfully."){
//                         //   //       status = 0;
//                         //   //     }
//                         //   //
//                         //   //   }else{
//                         //   //     ScaffoldMessenger.of(context).showSnackBar(
//                         //   //         SnackBar(content: Text('Otp Field Can not Empty...'), duration: Duration(seconds: 2),)
//                         //   //     );
//                         //   //   }
//                         //
//                         //   // Navigate to MainScreen when submit button is clicked
//                         //   // Navigator.pushReplacementNamed(context, '/main');
//                         //   // Get.to(Ragister());
//                         //   // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
//                         // },
//
//
//                         onPressed: () async {
//                           String mobileNumber = mobileNumberController.text.trim();
//
//                           if (mobileNumber.isEmpty) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text('📢 Please enter a mobile number!')),
//                             );
//                             return;
//                           }
//
//                           var isAvailable = await LoginService().checkMobileNumber(mobileNumber);
//
//                           if (isAvailable) {
//                             // ✅ Mobile Number is registered, now send OTP
//                             var data = await LoginService().getOtp(mobileNumber);
//
//                             if (data['status'] == true) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text('✅ OTP Sent Successfully!')),
//                               );
//
//                               await Future.delayed(const Duration(seconds: 1));
//
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (_) => OtpScreen(otp: data['otp'])),
//                               );
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text('❌ Failed to send OTP! Try again.')),
//                               );
//                             }
//                           } else {
//                             // 🆕 Mobile Number is NOT registered → Redirect to Register Screen
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text('🆕 This number is not registered. Please sign up!')),
//                             );
//
//                             await Future.delayed(const Duration(seconds: 1));
//
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (_) => RegisterScreen(mobile: mobileNumber)),
//                             );
//                           }
//                         },
//                         child: const Text(
//                           "SUBMIT",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     if(viewModel.statusMessage == "Otp Sent Succesfully.")
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10.0),
//                         child: Text(
//                           viewModel.statusMessage,
//                           style: TextStyle(
//                             color: viewModel.statusMessage == 'Otp Sent Succesfully.'
//                                 ? Colors.green
//                                 : Colors.red,
//                           ),
//                         ),
//                       ),
//                     const SizedBox(height: 20),
//
//                     // Signup & Login with Email Links
//                     Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text("Not a member ? "),
//                             GestureDetector(
//                               onTap: () {
//                                 // Navigate to Register Screen
//                                 // Get.to(RegisterScreen(mobile: '',));
//                               },
//                               child: const Text(
//                                 "Signup Now",
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10), // Space between links
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text("or "),
//                             GestureDetector(
//                               onTap: () {
//                                 // Navigate to Email Login Screen
//                                 Get.to(EmailLoginScreen());
//                               },
//                               child: const Text("Login with Email",
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/login_service.dart';
import 'package:fonofy/EmailLoginScreen.dart';
import 'package:fonofy/RegisterScreen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'ViewModel/MobileOtpSend.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileNumberController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: ChangeNotifierProvider(
        create: (_) => OtpViewModel(),
        child: Consumer<OtpViewModel>(
          builder: (context, viewModel, child) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ✅ Logo Section
                    SizedBox(
                      height: 100,
                      child: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 20),

                    // ✅ Login Image
                    SizedBox(
                      height: 40,
                      child: Image.asset('assets/images/login.png', fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Mobile No.",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      controller: mobileNumberController,
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
                        onPressed: isLoading ? null : _handleLogin,
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("SUBMIT",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),

                    if (viewModel.statusMessage == "Otp Sent Successfully.")
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          viewModel.statusMessage,
                          style: TextStyle(
                            color: viewModel.statusMessage == 'Otp Sent Successfully.'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),

                    // ✅ Signup & Login with Email Links
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Not a member? "),
                            GestureDetector(
                              onTap: () {
                                // Get.to(RegisterScreen(mobile: ''));
                              },
                              child: const Text(
                                "Signup Now",
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10), // Space between links
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("or "),
                            GestureDetector(
                              onTap: () {
                                Get.to(EmailLoginScreen());
                              },
                              child: const Text(
                                "Login with Email",
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ✅ Handle Login with OTP
  Future<void> _handleLogin() async {
    String mobileNumber = mobileNumberController.text.trim();
    if (mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('📢 Please enter a mobile number!')),
      );
      return;
    }
    setState(() => isLoading = true);

    try {
      var isAvailable = await LoginService().checkMobileNumber(mobileNumber);

      if (isAvailable) {
        // ✅ Registered User: Send OTP
        var data = await LoginService().getOtp(mobileNumber);

        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ OTP Sent Successfully!')),
          );
          await Future.delayed(const Duration(seconds: 1));
          Get.to(OtpScreen(otp: data['otp']));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('❌ Failed to send OTP! Try again.')),
          );
        }
      } else {
        // 🆕 Not Registered: Redirect to Signup
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('🆕 This number is not registered. Please sign up!')),
        );

        await Future.delayed(const Duration(seconds: 1));

        Get.to(RegisterScreen(mobile: mobileNumber));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
    } finally {
      setState(() => isLoading = false); // ✅ Hide Loader
    }
  }
}
