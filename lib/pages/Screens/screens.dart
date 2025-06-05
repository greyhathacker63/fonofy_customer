import 'package:flutter/material.dart';
import 'package:fonofy/pages/EmptyCartScreen/EmptyCartScreen.dart';
import 'package:fonofy/pages/ProductScreen/ProductScreen.dart';
import 'package:fonofy/pages/ReferAndEarnScreen/ReferAndEarnScreen.dart';
import 'package:fonofy/pages/MyOrdersScreen/MyOrdersScreen.dart';
import 'package:fonofy/pages/SelectColourScreen/SelectColourScreen.dart';
import 'package:fonofy/pages/SelectSlotScreen/SelectSlotScreen.dart';
import 'package:fonofy/pages/YourDeviceScreen/YourDeviceScreen5.dart';
import 'package:get/get.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Screens")),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(EmptyCartScreen());
            },
            child: const Text(
              "EmptyCart",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(ReferAndEarnScreen());
            },
            child: const Text(
              "Refer&Earn",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(ProductScreen());
            },
            child: const Text(
              "ProductScreen",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(SelectSlotScreen());
            },
            child: const Text(
              "SelectSlotScreen",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(YourDeviceScreen5());
            },
            child: const Text(
              "YourDeviceScreen5",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(SelectColourScreen());
            },
            child: const Text(
              "SelectColorScreen",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(MyOrdersScreen());
            },
            child: const Text(
              "MyOrders",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
