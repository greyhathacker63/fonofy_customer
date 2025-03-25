import 'package:flutter/material.dart';
import 'package:fonofy/Manage Address/ManageAddressScreen.dart'; // Updated import (no spaces)

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool servicesExpanded = false;
  bool settingsExpanded = false;
  bool aboutExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset("assets/images/Logo.png", height: 40),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information Section
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/images/phone.png"),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "FONOFY TECHNOLOGIES PVT.LTD.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "kuldeep@fonofy.in",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // My Orders
            const Text(
              "MY ORDERS",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),

            // Services Section (Expandable)
            _buildExpandableSection(
              "SERVICES",
              servicesExpanded,
              () {
                setState(() {
                  servicesExpanded = !servicesExpanded;
                });
              },
              servicesExpanded ? ["Sell Phone", "Repair Phone", "Recycle Phone", "Offline Stores"] : [],
              context,
            ),

            // Settings Section (Expandable)
            _buildExpandableSection(
              "SETTING",
              settingsExpanded,
              () {
                setState(() {
                  settingsExpanded = !settingsExpanded;
                });
              },
              ["Manage Address", "Manage Payments", "Delete My Account"],
              context, // Pass context correctly
            ),

            // About Section (Expandable)
            _buildExpandableSection(
              "ABOUT",
              aboutExpanded,
              () {
                setState(() {
                  aboutExpanded = !aboutExpanded;
                });
              },
              aboutExpanded ? ["About Us", "Contact Us", "Career"] : [],
              context,
            ),

            // Other Options
            _buildMenuItem("REFER & EARN"),
            _buildMenuItem("NEW OFFERS"),
            _buildMenuItem("MY EARNINGS"),
            _buildMenuItem("HELP"),

            const SizedBox(height: 20),

            // Logout Button
            Center(
              child: TextButton(
                onPressed: () {
                  // Add logout functionality here
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _buildExpandableSection(
    String title,
    bool isExpanded,
    VoidCallback onTap,
    List<String> subItems,
    BuildContext context, // Ensure BuildContext is included
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
            ],
          ),
        ),
        if (isExpanded)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: subItems.map((item) {
              return GestureDetector(
                onTap: () {
                  if (item == "Manage Address") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ManageAddressScreen()),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              );
            }).toList(),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}
