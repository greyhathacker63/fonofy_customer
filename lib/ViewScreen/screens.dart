import 'package:flutter/material.dart';
import 'package:fonofy/Cart_Screens/EmptyCartScreen.dart';
import 'package:fonofy/ProductScreens/ProductScreen.dart';
import 'package:fonofy/ReferAndEarnScreen/ReferAndEarnScreen.dart';
import 'package:fonofy/ViewScreen/Orders/MyOrders.dart';
import 'package:fonofy/ViewScreen/SelectColourScreen.dart';
import 'package:fonofy/ViewScreen/SelectSlotScreen.dart';
import 'package:fonofy/ViewScreen/YourDeviceScreen5.dart';
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
            child: const Text("EmptyCart",style:TextStyle(color: Colors.black, fontSize: 20),
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

