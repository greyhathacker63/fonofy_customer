import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
              _buildTextFieldWithVerify("Enter mobile no."),

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

              // Submit Button - Navigates to MainScreen
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
                    // Navigate to MainScreen when submit button is clicked
                    Navigator.pushReplacementNamed(context, '/main');
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

  // TextField with Verify Button Inside
  Widget _buildTextFieldWithVerify(String hint) {
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
}
