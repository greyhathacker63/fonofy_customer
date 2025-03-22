import 'package:flutter/material.dart';
import 'package:fonofy/BuyRefurbishedProductScreen';
import 'package:fonofy/EmptyCartScreen.dart';
import 'package:fonofy/ProductScreens/ProductScreen.dart';
import 'package:fonofy/ReferAndEarnScreen/ReferAndEarnScreen.dart';
import 'package:fonofy/SelectSlotScreen.dart';
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
              Get.to(BuyRefurbishedProductScreen());
            },
            child: const Text(
              "BuyRefurbishedScreen",
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
          
        ],
      ),
    );
  }
}
