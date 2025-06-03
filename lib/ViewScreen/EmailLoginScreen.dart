import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../MainScreen.dart';
import 'RegisterScreen.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ Email & Password can't be empty!"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() => isLoading = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString("Email");
    String? storedPassword = prefs.getString("Password");

    await Future.delayed(Duration(seconds: 2)); // API call simulation

    if (storedEmail != null && storedPassword != null && storedEmail == email && storedPassword == password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Login Successful!"), duration: Duration(seconds: 2)),
      );
      Get.offAll(() => MainScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Invalid Email or Password!"), duration: Duration(seconds: 2)),
      );
      passwordController.clear();
    }
    setState(() => isLoading = false);
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
              Image.asset('assets/images/Logo.png', height: 100, fit: BoxFit.contain),
              const SizedBox(height: 20),
              Image.asset('assets/images/login.png', height: 40, fit: BoxFit.contain),
              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF19628B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: isLoading ? null : _handleLogin,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "SUBMIT",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
                SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text("Not a member? "),
                  GestureDetector(
                    onTap: () => Get.to(() => RegisterScreen(mobile: '')),
                    child: Text(
                      "Signup Now",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
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
