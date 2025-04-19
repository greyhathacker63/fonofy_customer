import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AccountApiService/account_api_service.dart';
import '../AccountApiService/UpdateAccountDetails.dart';
import '../AccountDetailsModel/account_details_model.dart';

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
  bool isUpdating = false;
  AccountDetailsModel? _originalData;

  @override
  void initState() {
    super.initState();
    _fetchAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
                onPressed: isUpdating ? null : _fetchAccountUpdate,
                child: isUpdating
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save Changes", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          border: const OutlineInputBorder(),
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
        _originalData = data;
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

  Future<void> _fetchAccountUpdate() async {
    if (!mounted || _originalData == null) return;

    final prefs = await SharedPreferences.getInstance();
    final userCode = prefs.getString('UserCode') ?? '';

    final newData = AccountDetailsModel(
      userCode: userCode,
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      address: addressController.text.trim(),
      role: '',
      isActive: true,
      isEmailVerified: true,
      isPhoneVerified: true,
      password: '',
      platformType: '',
    );

    if (_isSameData(_originalData!, newData)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ No changes detected!")),
      );
      return;
    }

    setState(() => isUpdating = true);

    final response = await UpdateAccountDetailsService().updateAccountDetails(newData);

    if (!mounted) return;

    setState(() => isUpdating = false);

    if (response['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Details updated successfully!"),backgroundColor: Colors.green,),
      );
      await _fetchAccountDetails();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Update failed: ${response['message']}")),
      );
    }
  }

  bool _isSameData(AccountDetailsModel oldData, AccountDetailsModel newData) {
    return oldData.firstName == newData.firstName &&
        oldData.lastName == newData.lastName &&
        oldData.email == newData.email &&
        oldData.phoneNumber == newData.phoneNumber &&
        oldData.address == newData.address;
  }
}
