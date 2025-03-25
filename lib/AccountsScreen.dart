import 'package:flutter/material.dart';
import 'package:fonofy/account_details_screen_new.dart';

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
        title: Image.asset("assets/images/Logo.png", height: 30), // Update with your logo path
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
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/images/phone.png"),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "FONOFY TECHNOLOGIES PVT.LTD.",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),

            // Services Section (Expandable)
            _buildExpandableSection(
              title: "SERVICES",
              isExpanded: servicesExpanded,
              onTap: () => setState(() => servicesExpanded = !servicesExpanded),
              subItems: [
                "Sell Phone",
                "Repair Phone",
                "Recycle Phone",
                "Offline Stores"
              ],
            ),

            // Settings Section (Expandable)
            _buildExpandableSection(
              title: "SETTING",
              isExpanded: settingsExpanded,
              onTap: () => setState(() => settingsExpanded = !settingsExpanded),
              subItems: [
                "Manage Address",
                "Manage Payments",
                "Delete My Account",
              ],
              onItemTap: (item) {
                if (item == "Manage Address") {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const AccountDetailsScreen(),
                    ),
                  );
                } else if (item == "Manage Payments") {
                  // Navigate to Payment Screen (Define it first)
                } else if (item == "Delete My Account") {

                }
                }
            ),

            // About Section (Expandable)
            _buildExpandableSection(
              title: "ABOUT",
              isExpanded: aboutExpanded,
              onTap: () => setState(() => aboutExpanded = !aboutExpanded),
              subItems: ["About Us", "Contact Us", "Career"],
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

  /// **📌 Builds a menu item**
  Widget _buildMenuItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  /// **📌 Builds an expandable section with navigation**
  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<String> subItems,
    void Function(String)? onItemTap, // Optional tap handler for items
  }) {
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
            children: subItems.map((item) {
              return ListTile(
                title: Text(
                  item,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => onItemTap?.call(item),
              );
            }).toList(),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}
