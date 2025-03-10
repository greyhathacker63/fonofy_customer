import 'package:flutter/material.dart';
import 'package:fonofy/AllBrands.dart';
import 'package:fonofy/DeviceDetailsScreen4.dart';
import 'package:fonofy/EmptyCartScreen.dart';
import 'package:fonofy/DeviceDetailsScreen.dart';
import 'package:fonofy/DeviceDetailsScreen2.dart';
import 'package:fonofy/DeviceDetailsScreen3.dart';
import 'package:fonofy/SelectProductScreen.dart';
import 'package:fonofy/SideBarMenuScreen.dart';
import 'package:fonofy/YourDevice.dart';
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
      appBar: AppBar(title: const Text("Screens")),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(DeviceDetailsScreen());
            },
            child: const Text(
              "DeviceDetailsScreen",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(DeviceDetailScreen2()); // Fixed class name
            },
            child: const Text(
              "DeviceDetailsScreen2",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(DeviceDetailsScreen3());
            },
            child: const Text(
              "DeviceDetailsScreen3",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(DeviceDetailsScreen4());
            },
            child: const Text(
              "DeviceDetailsScreen4",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(AllBrandsScreen());
            },
            child: const Text(
              "AllBrands",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(SelectProductScreen());
            },
            child: const Text(
              "SelectProductScreen",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(EmptyCartScreen()); // Fixed class name
            },
            child: const Text(
              "EmptyCart",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(YourDeviceScreen()); // Fixed class name
            },
            child: const Text(
              "YourDeviceScreen",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
