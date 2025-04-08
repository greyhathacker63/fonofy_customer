import 'package:flutter/material.dart';
import 'package:fonofy/AllBrands.dart';
// import 'package:fonofy/BuyRefurbishedProductScreen';
import 'package:fonofy/DeviceDetailsScreen4.dart';
import 'package:fonofy/EmptyCartScreen.dart';
<<<<<<< HEAD
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
=======
import 'package:fonofy/DeviceDetailsScreen.dart';
import 'package:fonofy/DeviceDetailsScreen2.dart';
import 'package:fonofy/DeviceDetailsScreen3.dart';
import 'package:fonofy/ProductScreens/ProductScreen.dart';
import 'package:fonofy/ReferAndEarnScreen/ReferAndEarnScreen.dart';
import 'package:fonofy/RepairServiceScreen.dart';
import 'package:fonofy/SelectAddressScreen.dart';
import 'package:fonofy/SelectProduct2.dart';
import 'package:fonofy/SelectProductScreen.dart';
import 'package:fonofy/SelectProductScreen3';
import 'package:fonofy/YourDevice.dart';
import 'package:fonofy/YourDeviceScreen2.dart';
import 'package:fonofy/YourDeviceScreen3.dart';
>>>>>>> vinay/users
import 'package:get/get.dart';

import 'BuyRefurbishedProductScreen.dart';

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
              Get.to(DeviceDetailScreen2()); 
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
              Get.to(SelectAddressScreen()); 
            },
            child: const Text(
              "SelectAddressScreen",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
           GestureDetector(
            onTap: () {
              Get.to(SelectProductScreen3()); 
            },
            child: const Text(
              "SelectProduct",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
           GestureDetector(
            onTap: () {
              Get.to(SelectProduct2()); 
            },
            child: const Text(
              "SelectProduct2",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(EmptyCartScreen()); 
            },
            child: const Text(
              "EmptyCart",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
<<<<<<< HEAD
          
=======
          GestureDetector(
            onTap: () {
              Get.to(YourDeviceScreen());
            },
            child: const Text(
              "YourDeviceScreen",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(YourDeviceScreen2()); 
            },
            child: const Text(
              "YourDeviceScreen2",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
           GestureDetector(
            onTap: () {
              Get.to(YourDeviceScreen3()); 
            },
            child: const Text(
              "YourDeviceScreen3",
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
           
>>>>>>> vinay/users
          GestureDetector(
            onTap: () {
              Get.to(RepairServiceScreen()); 
            },
            child: const Text(
              "RepairServiceScreen",
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
<<<<<<< HEAD
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
          
=======
         
>>>>>>> vinay/users
        ],
      ),
    );
  }
}
