import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AccountApiService/account_api_service.dart';
import 'AccountDetailsModel/account_details_model.dart';

class AccountDetailsScreen extends StatefulWidget {

  const AccountDetailsScreen({super.key});
  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}
class _AccountDetailsScreenState extends State<AccountDetailsScreen> {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Account Details",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("First Name", firstNameController),
            _buildTextField("Last Name", lastNameController),
            _buildTextField("Email", emailController, TextInputType.emailAddress),
            _buildTextField("Phone Number", phoneNumberController, TextInputType.phone, true),
            _buildTextField("Address", addressController, TextInputType.streetAddress),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("✅ Details Saved!")),
                  );
                },
                child: const Text("Save Changes", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // **Reusable Text Field Function**
  Widget _buildTextField(String label, TextEditingController controller,
      [TextInputType keyboardType = TextInputType.text, bool isReadOnly = false]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _fetchAccountDetails() async {
    AccountDetailsModel? data = await AccountApiService().getAccountData();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (data != null) {
      if (!mounted) return;
      setState(() {
        firstNameController.text = data.firstName;
        lastNameController.text = data.lastName ?? '';
        emailController.text = data.email;
        phoneNumberController.text = data.phoneNumber;
        addressController.text = data.address ?? '';
        isLoading = false;

      });
      await prefs.setString('UserCode', data.userCode);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Failed to fetch account details!")),
      );
      setState(() => isLoading = false);
    }
  }
}
