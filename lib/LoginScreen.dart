import 'package:flutter/material.dart';
import 'package:fonofy/EmailLoginScreen.dart';
import 'package:fonofy/MainScreen.dart';
import 'package:fonofy/RegisterScreen.dart';
import 'package:fonofy/bottom_navgation.dart';
import 'package:fonofy/otp_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'ViewModel/MobileOtpSend.dart';

class LoginScreen extends StatelessWidget {
  // final TextEditingController mobileNumberController = TextEditingController();
  // final TextEditingController otpNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int status = 0;
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Section
              SizedBox(
                height: 100,
                child: Image.asset(
                  'assets/images/Logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // Login Image (Replaces "LOGIN" text & icon)
              SizedBox(
                height: 40,
                child: Image.asset(
                  'assets/images/login.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // Mobile Number Input Field
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Mobile No.",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 15),

              // OTP Input Field
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter OTP",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button - Navigate to RegisterScreen
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
                  onPressed: () {
                    Get.to(MainScreen());
                  },
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
=======
      backgroundColor: Colors.white, // Setting the background color to white
      body:  ChangeNotifierProvider(
        create: (_) => OtpViewModel(),
        child: Consumer<OtpViewModel>(
          builder: (context, viewModel, child) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Section
                    SizedBox(
                      height: 100, // Adjust height as per your logo
                      child: Image.asset(
                        'assets/images/Logo.png', // Replace with your logo path
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Login Image (Replaces "LOGIN" text & icon)
                    SizedBox(
                      height: 40, // Adjust height as needed
                      child: Image.asset(
                        'assets/images/login.png',
                        fit: BoxFit.contain,
                      ),
>>>>>>> vinay/users
                    ),
                    const SizedBox(height: 20),
                    // Mobile Number Input Field
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Mobile No.",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      // controller: mobileNumberController,
                    ),
                    const SizedBox(height: 15),

<<<<<<< HEAD
              // Signup & Login with Email Links
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a member ? "),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Register Screen
                          Get.to(RegisterScreen());
=======
                    // OTP Input Field

                    // TextField(
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //     labelText: "Enter OTP",
                    //     border: OutlineInputBorder(),
                    //     prefixIcon: Icon(Icons.lock),
                    //   ),
                    //   controller: otpNumberController,
                    // ),
                    const SizedBox(height: 20),

                    // Submit Button - Navigate to RegisterScreen
                    viewModel.isLoading? CircularProgressIndicator():
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF19628B), // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // if(status == 0){
                          //   if(mobileNumberController.text.toString().isNotEmpty){
                          //     final mobileNumber = mobileNumberController.text;
                          //     viewModel.sendOtp(mobileNumber);
                          //     if(viewModel.statusMessage == "Otp Sent Succesfully."){
                          //       status = 1;
                          //     }
                          //
                          //   }else{
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(content: Text('Mobile Number Can not Empty...'), duration: Duration(seconds: 2),)
                          //     );
                          //   }
                          // }else{
                          //   if(otpNumberController.text.toString().isNotEmpty){
                          //     final mobileNumber = otpNumberController.text;
                          //     viewModel.sendOtp(mobileNumber);
                          //     if(viewModel.statusMessage == "Otp Sent Succesfully."){
                          //       status = 0;
                          //     }
                          //
                          //   }else{
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(content: Text('Otp Field Can not Empty...'), duration: Duration(seconds: 2),)
                          //     );
                          //   }

                          // Navigate to MainScreen when submit button is clicked
                          // Navigator.pushReplacementNamed(context, '/main');
                          // Get.to(Ragister());
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
>>>>>>> vinay/users
                        },
                        child: const Text(
                          "SUBMIT",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
<<<<<<< HEAD
                    ],
                  ),
                  const SizedBox(height: 10),
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
=======
                    ),
                    if(viewModel.statusMessage == "Otp Sent Succesfully.")
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          viewModel.statusMessage,
>>>>>>> vinay/users
                          style: TextStyle(
                            color: viewModel.statusMessage == 'Otp Sent Succesfully.'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Signup & Login with Email Links
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Not a member ? "),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Register Screen
                                Get.to(OtpScreen());
                              },
                              child: const Text(
                                "Signup Now",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                // Navigate to Email Login Screen
                                Get.to(EmailLoginScreen());
                              },
                              child: const Text("Login with Email",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
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
}
