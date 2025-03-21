import 'package:flutter/material.dart';
import 'package:fonofy/BuyScreen/BuyScreen.dart';
import 'package:fonofy/RepairScreen/RepairScreen.dart';
import 'package:fonofy/SellScreen/SellScreen.dart';
import 'package:fonofy/widgets/Colors.dart';
import 'package:get/get.dart'; // Import GetX for navigation
import 'package:fonofy/CartScreen.dart'; // Import Cart Screen

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0; // Track the selected tab index

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Add listener to update UI when the tab changes
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image.asset("assets/images/Logo.png", height: 30),
        centerTitle: true,
        title: Text(
          _getTitle(_selectedIndex),
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          if (_selectedIndex == 0) 
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {
                Get.to(() =>  CartScreen()); 
              },
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: ColorConstants.appBlueColor2,
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: ColorConstants.appBlueColor3, // Selected tab background color
              ),
              unselectedLabelColor: Colors.white70,
              tabs: [
                _buildTab("BUY", 0),
                _buildTab("SELL", 1),
                _buildTab("REPAIR", 2),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [BuyScreen(), Sellscreen(), RepairScreen()],
      ),
    );
  }

  // Helper function to build tab with dynamic background color
  Widget _buildTab(String title, int index) {
    return Tab(
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? ColorConstants.appBlueColor3
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.white : Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

String _getTitle(int index) {
  switch (index) {
    case 0:
      return "Buy";
    case 1:
      return "Sell";
    case 2:
      return "Repair";
    default:
      return "Sell";
  }
}
