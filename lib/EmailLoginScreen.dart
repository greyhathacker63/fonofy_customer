import 'package:flutter/material.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Setting the background color to white
      body: Center(
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
                  'assets/images/login.png', // Replace with your login image path
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // Email Input Field
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),

              // Password Input Field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button - Navigate to MainScreen
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
              const SizedBox(height: 20),

              // Signup Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member ? "),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Register Screen
                      Navigator.pushNamed(context, '/register');
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
            ],
          ),
        ),
      ),
    );
  }
}
