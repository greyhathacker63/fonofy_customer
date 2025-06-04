import 'package:flutter/material.dart';
import 'package:fonofy/pages/ServiceScreen/ServiceScreen.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/pages/AccountScreen/AccountsScreen.dart';
import 'package:fonofy/pages/InfoScreen/InfoScreen.dart';
import 'package:fonofy/pages/AuthScreens/LoginScreen/LoginScreen.dart';
import 'package:fonofy/pages/SupportScreen/SupportScreen.dart';
import 'package:fonofy/widgets/TabScreen/TabScreen.dart';
import 'package:fonofy/widgets/ColorConstants/Colors.dart';

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
  late List<Widget?> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      TabScreen(upperTabIndex: widget.upperTabIndex),
      InfoScreen(),
      ServiceScreen(),
      SupportScreen(),

      null,
    ];
  }
  void onTap(int index) async {
    if (index == 4) {
      final token = await TokenHelper.getToken();
      if (token == null) {
        Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()),);
        return;
      } else {
        setState(() {
          screens[4] = AccountScreen();
          currentIndex = 4;
        });
        return;
      }
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: IndexedStack(
        index: currentIndex,
        children: List.generate(
          screens.length,
              (index) => screens[index] ?? const SizedBox(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.white,
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: "Profile",),
        ],
      ),
    );
  }
}
