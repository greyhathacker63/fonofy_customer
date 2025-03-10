import 'package:flutter/material.dart';
import 'package:fonofy/AccountsScreen.dart';
import 'package:fonofy/BuyScreen/BuyScreen.dart';

import 'package:fonofy/InfoScreen.dart';
import 'package:fonofy/ServicesScreen.dart';
import 'package:fonofy/SupportScreen.dart';
import 'package:fonofy/TabScreen.dart';
import 'package:fonofy/screens.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

List <Widget> screens=[TabScreen(),InfoScreen(),ServicesScreen(),SupportScreen(),AccountScreen(),Screens()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: screens,
        index:currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        onTap(index);
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
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
