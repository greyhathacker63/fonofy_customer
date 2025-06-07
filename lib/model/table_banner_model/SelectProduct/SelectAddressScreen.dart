import 'package:flutter/material.dart';
 import 'package:fonofy/Manage%20Address/AddNewAddressScreen.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';


class SelectAddressScreen extends StatelessWidget {

  const SelectAddressScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title:
              Text("Select Address", style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children:[
            SizedBox(height: 10),
          // Stepper UI with Adjusted Alignment
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepBox("1", true),
              Container(
                width: Get.width * 0.55,
                height: 1.5,
                color: Colors.black26,
              ),
              _buildStepBox("2", false),
            ],
          ),
            SizedBox(height: 5),

          Padding(
            padding:EdgeInsets.symmetric(horizontal: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text("Address",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text("Time Slot",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.appBlueColor3,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Get.to(() => AddNewAddressScreen(customerId: '', address: null,));
            },
            child: Text(
              "+Add New Address",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),

          const Spacer(),

           Container(
            padding:   EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(top: BorderSide(color: Colors.black12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text("₹99",
                    //     style: TextStyle(
                    //         fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("Apply Coupon",
                        style: TextStyle(fontSize: 12, color: Colors.green)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appBlueColor3,
                    padding:   EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // Get.to(() => SelectAddressRepairScreen());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:   EdgeInsets.only(left: 22),
                        child: Text("Book Now",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Step Box Widget
  Widget _buildStepBox(String step, bool isActive) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: isActive ? Colors.blue : Colors.black45),
        color: isActive ? Colors.white : Colors.black26,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Text(
        step,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.blue : Colors.white,
        ),
      ),
    );
  }
}
