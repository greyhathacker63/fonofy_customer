import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Manage%20Address/AddNewAddressScreen.dart';
import '../../../RepairScreen/RepairDateSelectorScreen.dart';
import '../../../utils/Colors.dart';
import '../../../TokenHelper/TokenHelper.dart';
import '../../../model/ShippingAddressModel/ListShippingAddressModel.dart';
import '../../../controllers/ControllerProductDetails/AddressRepairController.dart';

import '../../../controllers/RepairController/RepairServicesTableController.dart';


class SelectRepairAddressScreen extends StatelessWidget {
  const SelectRepairAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final AddressRepairController addressController = Get.put(AddressRepairController());
    final RepairControllerTable repairController = Get.find<RepairControllerTable>();


    void _navigateToAddNewAddressScreen() async {
      String? customerId = await TokenHelper.getUserCode();
      if (customerId == null || customerId.isEmpty) {
        Get.snackbar('Error', 'User not logged in',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
      print('Navigating to AddNewAddressScreen with customerId: $customerId');
      final result = await Get.to(() => AddNewAddressScreen(
        customerId: customerId,
        address: ListShippingAddressModel(),
      ));
      if (result == true) {
        print('New address added, refreshing list');
        addressController.fetchAddresses();
      }
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text("Select Address", style: TextStyle(color: Colors.black)),
      ),
      body: Obx(
            () => Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStepBox("1", true),
                    Container(width: Get.width * 0.55, height: 1.5, color: Colors.black26),
                    _buildStepBox("2", false),
                  ],
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Address", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Text("Time Slot", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black45)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appBlueColor3,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _navigateToAddNewAddressScreen,
                  child: Text("+ Add New Address",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                addressController.isLoading.value
                    ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (_, __) => _buildShimmerEffect(),
                )
                    : addressController.addressList.isEmpty
                    ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(""),
                )
                    : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    itemCount: addressController.addressList.length,
                    itemBuilder: (context, index) {
                      final address = addressController.addressList[index];
                      return Obx(
                            () => InkWell(
                          onTap: () {
                            print('Tapped address at index: $index');
                            addressController.selectAddress(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: addressController.selectedAddressIndex.value == index
                                    ? ColorConstants.appBlueColor3
                                    : Colors.black12,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${address.name ?? ' '} | ${address.workType ?? ''}",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    address.address ?? "No address provided",
                                    style: const TextStyle(fontSize: 14, color: Colors.black),
                                  ),
                                  Text(
                                    "${address.city ?? ''} - ${address.pinCode ?? ''}",
                                    style: const TextStyle(fontSize: 14, color: Colors.black),
                                  ),
                                  Text(
                                    "📞 ${address.mobileNo ?? ''}",
                                    style: const TextStyle(fontSize: 14, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // if (bookingController.isLoading.value)
            //   Container(
            //     color: Colors.black.withOpacity(0.5),
            //     child:   Center(child: CircularProgressIndicator()),
            //   ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
            () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    repairController.totalPrice.value > 0
                        ? "₹${repairController.totalPrice.value}"
                        : "₹0",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                    Text(
                    "Apply Coupon",
                    style: TextStyle(fontSize: 12, color: ColorConstants.appBlueColor3),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addressController.selectedAddressIndex.value != -1 &&
                      repairController.totalPrice.value > 0 &&
                      repairController.selectedServices.isNotEmpty &&
                      repairController.selectedServices.value.isNotEmpty &&
                      repairController.selectedServices.value.isNotEmpty
                      ? ColorConstants.appBlueColor3
                      : Colors.grey,
                  padding:   EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: addressController.selectedAddressIndex.value != -1 &&
                    repairController.totalPrice.value > 0 &&
                    repairController.selectedServices.isNotEmpty &&
                    repairController.selectedServices.value.isNotEmpty &&
                    repairController.selectedServices.value.isNotEmpty
                    ? () {
                  _showRepairOptionBottomSheet(context);
                }
                    : null,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 22),
                      child: Text("Book Now", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(4, (index) {
              return Padding(
                padding:   EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  height: 14,
                  width: index == 3 ? 100 : double.infinity,
                  color: Colors.white,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _showRepairOptionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding:   EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Choose an Option",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.clear, size: 30),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _optionCard(
              icon: Icons.home_repair_service_outlined,
              title: "Repair at Home",
              subtitle: "Just book and Relax! We’ll send our expert technician at your doorstep.",
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (_) => RepairDateSelectorScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            _optionCard(
              icon: Icons.storefront_outlined,
              title: "Repair at Store",
              subtitle: "Visit nearest store and avail expert repair on the spot.",
              badge: "Get Extra ₹300 OFF",
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _optionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    String? badge,
    VoidCallback? onTap, // add this
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:   EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade50,
        ),
        child: Row(
          children: [
            Icon(icon, size: 38, color: ColorConstants.appBlueColor3),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  if (badge != null)
                    Container(
                      margin: const EdgeInsets.only(top: 4, bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(badge, style: const TextStyle(color: Colors.green, fontSize: 12)),
                    ),
                  Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

