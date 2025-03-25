import 'package:flutter/material.dart';
import 'package:fonofy/controllers/Controller.dart';
import 'package:fonofy/otp_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'Api_Service/api_register.dart';
import 'model/register_model.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Controller controller = Get.put(Controller());

  // final String token = "eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6InNhbXBsZSBzdHJpbmcgMyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJzYW1wbGUgc3RyaW5nIDEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJzYW1wbGUgc3RyaW5nIDIiLCJMb2dpblRpbWUiOiIzLzIyLzIwMjUgMTowNzowMiBQTSIsIm5iZiI6MTc0MjYyOTAyMiwiZXhwIjoxNzQyNjMwODIyLCJpc3MiOiJTaGl2YW0gU2hhcm1hIiwiYXVkIjoiRm9ub0FwaSJ9.SSaKhmums1hCVijhYkeXdiytXcU3m-NPQIkwWchi7Us";

  // Register function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color set to white
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Section
              SizedBox(
                height: 100, // Adjust height as needed
                child: Image.asset(
                  'assets/images/Logo.png', // Replace with actual logo path
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // Replacing REGISTER text and icon with an image
              SizedBox(
                height: 40, // Adjust height as needed
                child: Image.asset(
                  'assets/images/register.png', // Replace with actual image path
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // Name Field
              _buildTextField("Enter name"),

              // Mobile Number Field with Verify Button inside
              _buildTextFieldWithVerify("Enter mobile no.",mobileController),

              // OTP Field
              _buildTextField("Enter OTP"),

              // Email Field
              _buildTextField("Enter email id"),

              // // PAN Number Field with Verify Button inside
              // _buildTextFieldWithVerify("Enter PAN No."),

              // // Aadhaar Number Field with Verify Button inside
              // _buildTextFieldWithVerify("Enter Aadhaar No."),

              // // GST Field with Verify Button inside
              // _buildTextFieldWithVerify("GST"),

              // Password Field
              _buildTextField("Create Password"),

              const SizedBox(height: 20),

              // Submit Button - Navigates to OTP Screen
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
                  onPressed: (){
                    Get.to(() => OtpScreen());
                    register();
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Normal TextField
  Widget _buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithVerify(
      String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(),
          suffixIcon: TextButton(
            onPressed: () {
              // Add verification logic here
            },
            child: const Text(
              "Verify",
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



  register() async {
    await controller
        .register(
            firstName: nameController.text.toString(),
            email: emailController.text.toString(),
            password: passwordController.text.toString(),
            phoneNumber: mobileController.text.toString())
        .then((value) async {
      // Navigator.pop(context);

      if (controller.getRegisterData!.token!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Success")),
        );
        Get.to(OtpScreen());

        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Failure")),
        );
      }
    });
  }

  // Future<void> _registerUser() async {
  //   final firstName = nameController.text;
  //   final phoneNumber = mobileController.text;
  //   final email = emailController.text;
  //   final password = passwordController.text;

  //   // Validate fields
  //   if (firstName.isEmpty ||
  //       phoneNumber.isEmpty ||
  //       email.isEmpty ||
  //       password.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('All fields are required!')),
  //     );
  //     return;
  //   }
  //   // Create a register request string with all data
  //   String registerData = json.encode({
  //     "FirstName": firstName,
  //     "PhoneNumber": phoneNumber,
  //     "Email": email,
  //     "Password": password,
  //   });
  //   try {
  //     // Call Register API using the service
  //     final registerService = RegisterService();
  //     final RegisterModel registerModel =
  //         await registerService.registerApi(registerData);

  //     // If registration is successful, navigate to OTP Screen
  //     if (registerModel.success) {
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //             content: Text(
  //                 'Registration Succesfully 👌👌👌: ${registerModel.message}')),
  //       );
  //       Get.to(OtpScreen());
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $e')),
  //     );
  //   }
  // }



}
