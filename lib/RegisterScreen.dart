import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'Api_Service/api_register.dart';
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
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  // final String token = "eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6InNhbXBsZSBzdHJpbmcgMyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJzYW1wbGUgc3RyaW5nIDEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJzYW1wbGUgc3RyaW5nIDIiLCJMb2dpblRpbWUiOiIzLzIyLzIwMjUgMTowNzowMiBQTSIsIm5iZiI6MTc0MjYyOTAyMiwiZXhwIjoxNzQyNjMwODIyLCJpc3MiOiJTaGl2YW0gU2hhcm1hIiwiYXVkIjoiRm9ub0FwaSJ9.SSaKhmums1hCVijhYkeXdiytXcU3m-NPQIkwWchi7Us";

  // Register function

  @override
  void initState() {
    super.initState();
    initValue();
  }

  initValue(){
    setState(() {
      phoneNumberController.text = widget.mobile;
    });
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
              // Logo Section
              SizedBox(
                height: 100,
                child: Image.asset(
                  'assets/images/Logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // Register Text and Icon (Image)
              SizedBox(
                height: 40,
                child: Image.asset(
                  'assets/images/register.png',
                  // Replace with actual image path
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // Name Field
              _buildTextField("Enter FirstName", firstNameController ),
              _buildTextField("Enter LastName", lastNameController),
              // Mobile Number Field with Verify Button inside
              _buildTextFieldWithVerify("Enter mobile no.", phoneNumberController),
              // Email Field
              _buildTextField("Enter email id", emailController),
              // Password Field
              // _buildTextField("Create Password", passwordController),


              const SizedBox(height: 20),

              // Submit Button - Navigates to OTP Screen
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
                  onPressed: _registerUser,
                  child: const Text("SUBMIT",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Normal TextField with a controller
  Widget _buildTextField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithVerify(String hint,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(),
          suffixIcon: TextButton(
            onPressed: () {
              // Add logic for verifying the mobile number
            },
            child: const Text("Verify",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _registerUser() async {
  //   final name = nameController.text;
  //   final mobile = mobileController.text;
  //   final email = emailController.text;
  //   final password = passwordController.text;
  //
  //   // Validate fields
  //   if (name.isEmpty || mobile.isEmpty || email.isEmpty || password.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('All fields are required!')),
  //     );
  //     return;
  //   }
  //   // Create a register request string with all data
  //   String registerData = jsonEncode({
  //     "name": name,
  //     "mobile": mobile,
  //     "email": email,
  //     "password": password
  //   });
  //
  //   try {
  //     // Call Register API using the service
  //     final registerService = RegisterService();
  //     final RegisterModel registerModel = await registerService.registerApi(registerData.toString(); RegisterModel;
  //
  //         // If registration is successful, navigate to OTP Screen
  //         if (registerModel.success) {
  //       Get.to(OtpScreen());
  //     } else {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(content: Text('Registration failed: ${registerModel.message}')),
  //   );
  //   }
  //   } catch (e) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(content: Text('Error: $e')),
  //   );
  //   }
  // }

  Future<void> _registerUser() async {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final phoneNumber = phoneNumberController.text;
    final email = emailController.text;
    // final password = passwordController.text;

    if (firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required!')),
      );
      return;
    }
    // Create a register request string with all data
    String registerData = json.encode({
      "FirstName": firstName,
      "LastName": lastName,
      "PhoneNumber": phoneNumber,
      "Email": email,
      // "Password": password,
    });
    try {
      // Call Register API using the service
      final registerService = RegisterService();
      final RegisterModel registerModel = await registerService.registerApi(registerData);

      if (registerModel.success) {
       } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Successfully 👌👌👌: ${registerModel.message}')),
        );
        Get.to(OtpScreen(otp: ''));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }










}
