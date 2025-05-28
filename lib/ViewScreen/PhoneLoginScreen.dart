import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../MainScreen.dart';
import 'RegisterScreen.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<PhoneLoginScreen> {

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Future<void> _handleLogin() async {
  //   final phone = phoneController.text.trim();
  //   final password = passwordController.text.trim();
  //
  //
  //   if (phone.isEmpty || password.isEmpty) {
  //     Get.to(()=>MainScreen());
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("❌ Phone & Password can't be empty!"),
  //         duration: Duration(seconds: 2),
  //
  //       ),
  //     );
  //     return;
  //
  //   }
  //
  //   setState(() => isLoading = true);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? storedPhone = prefs.getString("Phone");
  //   String? storedPassword = prefs.getString("Password");
  //
  //   await Future.delayed(Duration(seconds: 2));
  //
  //   if (storedPhone != null && storedPassword != null && storedPhone == phone && storedPassword == password) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("✅ Login Successful!"), duration: Duration(seconds: 2)),
  //     );
  //     Get.offAll(() => MainScreen());
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("❌ Invalid Phone  or Password!"), duration: Duration(seconds: 2)),
  //     );
  //     passwordController.clear();
  //   }
  //   setState(() => isLoading = false);
  // }

  Future<void> _handleLogin() async {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    if (phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ Phone & Password can't be empty!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() => isLoading = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPhone = prefs.getString("Phone");
    String? storedPassword = prefs.getString("Password");

    await Future.delayed(Duration(seconds: 2));

    if (storedPhone != null && storedPassword != null && storedPhone == phone && storedPassword == password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Login Successful!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Get.offAll(() =>  MainScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ Invalid Phone or Password!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
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
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  counterText: '', // hides character counter
                ),

              ),

                SizedBox(height: 15),

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
                SizedBox(height: 20),

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
                      : const Text("SUBMIT",
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
