import 'package:flutter/material.dart';
import 'package:fonofy/widgets/TabScreen/TabScreen.dart';
import 'package:fonofy/widgets/BottomNavigation/BottomNavigation.dart';
import 'package:fonofy/widgets/ColorConstants/Colors.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Container(
                margin: EdgeInsets.only(bottom: 30),
                color: Colors.white,
                child: Image.asset(
                  // height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.50,
                  'assets/images/Logo.png',
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Buy Card
              GestureDetector(
                onTap: () => Get.to(BottomNavigation(upperTabIndex:0)),
                child: _buildCard(
                    "Buy",
                    "Shop for certified refusrbished devices with 6 months warranty",
                    context),
              ),

              // Sell Card
              GestureDetector(
                onTap: () => Get.to(BottomNavigation(upperTabIndex: 1)),
                child: _buildCard(
                    "Sell",
                    "Get the best price for your old phone within 60 Seconds",
                    context),
              ),

              // Repair Card
               GestureDetector(
                onTap: () => Get.to(BottomNavigation(upperTabIndex: 2)),
                child: _buildCard(
                    "Repair",
                    "Expert Phone repair with 6 months warranty at doorstep or at store",
                    context),
              ),
              // GestureDetector
              // _buildCard(
              //     "Repair",
              //     "Expert Phone repair with 6-month warranty at doorstep or at store",
              //     context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: ColorConstants.appBlueColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: ColorConstants.appGreyColor),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 10)),
          trailing: const Icon(Icons.arrow_forward, color: Color(0xFF19628B)),
        ),
      ),
    );
  }
}
