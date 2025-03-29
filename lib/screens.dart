import 'package:flutter/material.dart';
import 'package:fonofy/BuyRefurbishedProductScreen';
import 'package:fonofy/EmptyCartScreen.dart';
import 'package:fonofy/Make%20Payments/MyPaymentScreen.dart';
import 'package:fonofy/Make%20Payments/SavedPaymentScreen.dart';
import 'package:fonofy/Orders/OrderScreen.dart';
import 'package:fonofy/Orders/OrderScreen2.dart';
import 'package:fonofy/ProductScreens/ProductScreen.dart';
import 'package:fonofy/ReferAndEarnScreen/ReferAndEarnScreen.dart';
import 'package:fonofy/SelectColourScreen.dart';
import 'package:fonofy/SelectSlotScreen.dart';
import 'package:fonofy/YourDeviceScreen5.dart';
import 'package:fonofy/YourDeviceScreen6.dart';
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
              Get.to(YourDeviceScreen5());
            },
            child: const Text(
              "YourDeviceScreen5",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
           GestureDetector(
            onTap: () {
              Get.to(MyPaymentScreen());
            },
            child: const Text(
              "MyPayment",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
           GestureDetector(
            onTap: () {
              Get.to(SavedPaymentScreen());
            },
            child: const Text(
              "SavedPayment",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(OrderScreen());
            },
            child: const Text(
              "OrderScreen",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(OrderScreen2());
            },
            child: const Text(
              "OrderScreen2",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
           GestureDetector(
            onTap: () {
              Get.to(YourDeviceScreen6());
            },
            child: const Text(
              "Your Device",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          
        ],
      ),
    );
  }
}
