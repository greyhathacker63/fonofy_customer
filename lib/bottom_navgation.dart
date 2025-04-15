import 'package:flutter/material.dart';
import 'package:fonofy/AccountsScreen.dart';
import 'package:fonofy/InfoScreen.dart';
import 'package:fonofy/ServicesScreen.dart';
import 'package:fonofy/SupportScreen.dart';
import 'package:fonofy/TabScreen.dart';
import 'package:fonofy/screens.dart';
import 'package:fonofy/widgets/Colors.dart';

class BottomNavigation extends StatefulWidget {
  final int upperTabIndex;
  
  const BottomNavigation({
    Key? key,
    required this.upperTabIndex,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  late List<Widget> screens; // Define it here

  @override
  void initState() {
    super.initState();
    screens = [
      TabScreen(upperTabIndex: widget.upperTabIndex), 
      InfoScreen(),
      ServicesScreen(),
      SupportScreen(),
      AccountScreen(),
      Screens(),
    ];
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorConstants.appBlueColor3,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Info",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support),
            label: "Support",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Screens",
          ),
        ],
      ),
    );
  }
}
