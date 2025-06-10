import 'package:flutter/material.dart';
import 'package:fonofy/ManagePayments/MyPaymentsScreen.dart';
import 'package:fonofy/ViewScreen/LoginScreen.dart';
import 'package:fonofy/MainScreen.dart';
import 'package:fonofy/Manage%20Address/ManageAddressScreen.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/ViewScreen/Orders/MyOrders.dart';
import 'package:fonofy/ViewScreen/TabScreen.dart';
import 'package:fonofy/ViewScreen/account_details_screen_new.dart';
import 'package:fonofy/changePassword/change_password_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AccountApiService/DeleteAccountService.dart';
import '../utils/Colors.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool servicesExpanded = false;
  bool settingsExpanded = false;
  bool aboutExpanded = false;
  bool isLoading = true;
  String userCode = "";
  String token = "";

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    String? token_au = await TokenHelper.getToken();
    String? userCode_b = await TokenHelper.getUserCode();
    if (token_au == null) {
      Get.offAll(() => LoginScreen());
    } else {
      setState(() {
        userCode = userCode_b ?? "";
        token = token_au ?? "";
        isLoading = false;
      });
    }
  }

  void _navigateToManageAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString("UserCode");
    if (customerId != null && customerId.isNotEmpty && token.isNotEmpty) {
      Get.to(() => ManageAddressScreen(customerId: customerId));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ User code is missing!",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _logout() async {
    await TokenHelper.removeToken();
    await TokenHelper.removeUserCode();
    await TokenHelper.deleteUserData();
    String? tok = await TokenHelper.getToken();
    if (tok == null) {
      Get.offAll(() => LoginScreen());
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              "Delete Account?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content:
                const Text("Are you sure you want to delete your account?"),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child:
                    const Text("Cancel", style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.appBlueColor3,
                ),
                onPressed: () async {
                  try {
                    final token = await TokenHelper.getToken();
                    final userCode = await TokenHelper.getUserCode();
                    if (token == null || userCode == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Missing user credentials")),
                      );
                      return;
                    }
                    final success =
                        await DeleteAccountService.deleteUserProfile(
                            token, userCode);
                    if (success) {
                      await TokenHelper.deleteUserData();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Account deleted successfully"),
                            backgroundColor: Colors.green),
                      );
                      Get.offAll(() => MainScreen());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Account deletion failed"),
                            backgroundColor: Colors.red),
                      );
                    }
                  } catch (e) {
                    print("❌ Error: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("An unexpected error occurred")),
                    );
                  }
                },
                child:
                    const Text("Delete", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserInfo(),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => MyOrdersScreen());
                    },
                    child: _buildSectionTitle("MY ORDERS"),
                  ),
                  const SizedBox(height: 10),
                  _buildExpandableSection(
                    title: "SERVICES",
                    isExpanded: servicesExpanded,
                    onTap: () =>
                        setState(() => servicesExpanded = !servicesExpanded),
                    subItems: [
                      "Sell Phone",
                      "Repair Phone",
                      "Recycle Phone",
                      "Offline Stores"
                    ],
                    onItemTap: (item) {
                      if (item == "Sell Phone") {
                        Get.to(() => TabScreen(upperTabIndex: 1));
                      } else if (item == "Repair Phone") {
                        Get.to(() => TabScreen(upperTabIndex: 2));
                      }
                    },
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
      Get.to(() => ManageAddressScreen(customerId: userCode));
    } else if (item == "Manage Payments") {
      Get.to(() => MyPaymentsScreen()); // FIXED ✅
    } else if (item == "Profile Account") {
      Get.to(() => AccountDetailsScreen());
    } else if (item == "Delete My Account") {
      _showDeleteDialog();
    }
  },
)
,
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
                  _buildMenuItem("ChangePassword", onTap: () {
                    Get.to(() => ChangePasswordScreen());
                  }),
                  const SizedBox(height: 50),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.appBlueColor3,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 8),
                      ),
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext alertContext) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text(
                                "Logout?",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              content: const Text(
                                  "Are you sure you want to log out?"),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade300,
                                  ),
                                  onPressed: () {
                                    Navigator.of(alertContext).pop();
                                  },
                                  child: const Text("Cancel",
                                      style: TextStyle(color: Colors.black)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        ColorConstants.appBlueColor3,
                                  ),
                                  onPressed: () {
                                    Navigator.of(alertContext).pop();
                                    _logout();
                                  },
                                  child: const Text("Logout",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Log Out",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
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
            Text("FONOFY TECHNOLOGIES PVT.LTD.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text("kuldeep@fonofy.in", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black));
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
              Text(title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black),
            ],
          ),
        ),
        if (isExpanded)
          Column(
            children: subItems.map((item) {
              return ListTile(
                title: Text(item,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
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
