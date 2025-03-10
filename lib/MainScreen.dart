import 'package:flutter/material.dart';
import 'package:fonofy/TabScreen.dart';
import 'package:fonofy/bottom_navgation.dart';
import 'package:fonofy/widgets/Colors.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo

            Container(
              margin: EdgeInsets.only(bottom: 30),
              color: Colors.amberAccent,
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
              onTap: () => Get.to(BottomNavigation()),
              child: _buildCard(
                  "Buy",
                  "Get the best price for your old phone within 60 Seconds",
                  context),
            ),

            // Sell Card
            GestureDetector(
              onTap: () => Get.to(BottomNavigation()),
              child: _buildCard(
                  "Sell",
                  "Get the best price for your old phone within 60 Seconds",
                  context),
            ),

            // Repair Card
            _buildCard(
                "Repair",
                "Expert Phone repair with 6-month warranty at doorstep or at store",
                context),
          ],
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
            side: BorderSide(color: ColorConstants.appGreyColor)),
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
