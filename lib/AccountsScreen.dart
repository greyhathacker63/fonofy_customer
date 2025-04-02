import 'package:flutter/material.dart';
import 'package:fonofy/LoginScreen.dart';
import 'package:fonofy/Manage%20Address/ManageAddressScreen.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/account_details_screen_new.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await TokenHelper.getToken();
    String? storedUserCode = prefs.getString("UserCode");

    if (token == null || token.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      setState(() {
        userCode = storedUserCode ?? "";
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
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

  Widget _buildMenuItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}
