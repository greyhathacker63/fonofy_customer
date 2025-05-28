import 'package:flutter/material.dart';
import 'package:fonofy/MainScreen.dart';
import '../Api_Service/ChangePasswordService/ChangePasswordService.dart';
import '../TokenHelper/TokenHelper.dart';
import '../utils/Colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isOldVisible = false;
  bool _isNewVisible = false;
  bool _isConfirmVisible = false;

  bool _isLoading = false;

  Future<void> _handleChangePassword() async {
    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }
    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("New passwords do not match")),
      );
      return;
    }

    final userCode = await TokenHelper.getUserCode();
    final token = await TokenHelper.changePasswordToken();

    if (userCode == null || token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not found")),
      );
      return;
    }

    setState(() => _isLoading = true);
    final success = await ChangePasswordService.changePassword(
      customerId: userCode,
      newPassword: newPassword, token: token,
    );
    setState(() => _isLoading = false);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password changed successfully"), backgroundColor: Colors.green),
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pop(context);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()),);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to change password"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 285),
                child: const Icon(Icons.close, size: 28.0, color: Colors.black),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  child: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
                ),
                SizedBox(height: 30,),
                _buildPasswordField("Old Password", _oldPasswordController, _isOldVisible, () {
                  setState(() => _isOldVisible = !_isOldVisible);
                }),
                const SizedBox(height: 16),
                _buildPasswordField("New Password", _newPasswordController, _isNewVisible, () {
                  setState(() => _isNewVisible = !_isNewVisible);
                }),
                const SizedBox(height: 16),
                _buildPasswordField("Confirm New Password", _confirmPasswordController, _isConfirmVisible, () {
                  setState(() => _isConfirmVisible = !_isConfirmVisible);
                }),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleChangePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.appBlueColor3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,)
                        : const Text("Change Password", style: TextStyle(color: Colors.white,fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool isVisible, VoidCallback toggle) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: toggle,
        ),
      ),
    );
  }
}
