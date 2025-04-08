import 'package:flutter/material.dart';
import 'package:fonofy/LoginScreen.dart';
import 'package:fonofy/MainScreen.dart';
import 'package:fonofy/Manage%20Address/ManageAddressScreen.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/account_details_screen_new.dart';
import 'package:fonofy/changePassword/change_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AccountApiService/DeleteAccountService.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool servicesExpanded = false;
  bool settingsExpanded = false;
  bool aboutExpanded = false;
  String userCode = "";
  String token  = "";

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token_au = await TokenHelper.getToken();
    String? storedUserCode = prefs.getString("UserCode");

    if (token_au == null || token_au.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      setState(() {
        userCode = storedUserCode ?? "";
        token = token_au;
      });
    }
  }

  void _navigateToManageAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString("UserCode");
    if (customerId != null && customerId.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ManageAddressScreen(customerId: customerId)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ User code is missing!")),
      );
    }
  }

  void _logout() async {
    await TokenHelper.removeToken();
    await TokenHelper.removeUserCode();
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset("assets/images/Logo.png", height: 30),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfo(),
            const SizedBox(height: 20),
            _buildSectionTitle("MY ORDERS"),
            const SizedBox(height: 10),
            _buildExpandableSection(
              title: "SERVICES",
              isExpanded: servicesExpanded,
              onTap: () => setState(() => servicesExpanded = !servicesExpanded),
              subItems: ["Sell Phone",
                "Repair Phone",
                "Recycle Phone",
                "Offline Stores"
              ],
            ),
            _buildExpandableSection(
              title: "SETTING",
              isExpanded: settingsExpanded,
              onTap: () => setState(() => settingsExpanded = !settingsExpanded),
              subItems: [
                "Manage Address",
                "Manage Payments",
                "Profile Account",
                "Delete My Account"
              ],
              onItemTap: (item) {
                if (item == "Manage Address") {
                  _navigateToManageAddress();
                } else if (item == "Profile Account") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountDetailsScreen()),
                  );
                }
                else if (item == "Delete My Account") {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    // Prevents closing the dialog by tapping outside
                    builder: (BuildContext context) {
                      return WillPopScope(
                        onWillPop: () async => false, // Disables back button
                        child: AlertDialog(
                          title: const Text("Delete Account"),
                          content: const Text(
                              "Are you sure you want to delete your account?"),
                          actions: [
                            // Cancel button
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text("Cancel"),
                            ),
                            // Delete button
                            TextButton(
                              onPressed: () async {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => MainScreen(),));
                                try {
                                  final token = await TokenHelper.getToken();
                                  final userCode = await TokenHelper
                                      .getUserCode();
                                  if (token == null || userCode == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text(
                                          "Missing user credentials")),
                                    );
                                    return;
                                  }
                                  final success = await DeleteAccountService
                                      .deleteUserProfile(token, userCode);
                                  if (success) {
                                    await TokenHelper.deleteUserData();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text(
                                          "Account deleted successfully"),backgroundColor: Colors.green,),
                                    );
                                     Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
                                          builder: (context) => MainScreen()),
                                          (route) => false,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Account deletion failed"),backgroundColor: Colors.red,),
                                    );
                                  }
                                } catch (e) {
                                  print("❌ Error: $e");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text(
                                        "An unexpected error occurred")),
                                  );
                                }
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.red),
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
            _buildExpandableSection(
              title: "ABOUT",
              isExpanded: aboutExpanded,
              onTap: () => setState(() => aboutExpanded = !aboutExpanded),
              subItems: ["About Us", "Contact Us", "Career"],
            ),
            _buildMenuItem("REFER & EARN"),
            _buildMenuItem("NEW OFFERS"),
            _buildMenuItem("MY EARNINGS"),
            _buildMenuItem("HELP"),

            _buildMenuItem("ChangePassword",
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
                );
              },
            ),

            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: _logout,
                child: const Text("Logout", style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildUserInfo() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("assets/images/phone.png"),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("FONOFY TECHNOLOGIES PVT.LTD.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text("kuldeep@fonofy.in", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<String> subItems,
    void Function(String)? onItemTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
              Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.black),
            ],
          ),
        ),
        if (isExpanded)
          Column(
            children: subItems.map((item) {
              return ListTile(
                title: Text(item, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                onTap: () => onItemTap?.call(item),
              );
            }).toList(),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
  Widget _buildMenuItem(String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
