import 'package:flutter/material.dart';
import 'package:fonofy/controllers/ControllerProductDetails/ControllerProductDetails.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:fonofy/model/RepairModel/BookingRepairModel.dart';
import 'package:fonofy/model/RepairModel/RepairServicesTableModel.dart';
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
  final String brandId;
  final String modelId;
  final String colorId;
  final dynamic totalPrice;
  final List<Table1> selectedServices;
  final ListShippingAddressModel? address;
  final selectedAddress;

  SelectRepairAddressScreen({
    super.key,
    required this.brandId,
    required this.modelId,
    required this.colorId,
    required this.totalPrice,
    required this.selectedServices,
    this.address,
    this.selectedAddress,
  });

@override
Widget build(BuildContext context) {
  final addressController = Get.put(AddressRepairController());
  final repairController = Get.put(RepairControllerTable());

  // Fetch addresses on init (if not already fetched)
  if (addressController.addressList.isEmpty && !addressController.isLoading.value) {
    addressController.fetchAddresses();
  }

  // Auto-select the previously selected address (after address list loads)
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (address != null && addressController.addressList.isNotEmpty) {
      final index = addressController.addressList.indexWhere((a) => a.id == address!.id);
      if (index != -1) {
        addressController.selectAddress(index);
      }
    }
  });

  void _navigateToAddNewAddressScreen() async {
    String? customerId = await TokenHelper.getUserCode();
    if (customerId == null || customerId.isEmpty) {
      Get.snackbar('Error', 'User not logged in',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    final result = await Get.to(() => AddNewAddressScreen(
          customerId: customerId,
          address: ListShippingAddressModel(),
        ));
    if (result == true) {
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
    body: Obx(() {
      return Stack(
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
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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
                child: const Text("+ Add New Address", style: TextStyle(fontSize: 16, color: Colors.white)),
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
                          child: Text("No addresses found"),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            itemCount: addressController.addressList.length,
                            itemBuilder: (context, index) {
                              final addr = addressController.addressList[index];
                              return Obx(
                                () => InkWell(
                                  onTap: () => addressController.selectAddress(index),
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
                                            "${addr.name ?? ''} | ${addr.workType ?? ''}",
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            addr.address ?? "No address provided",
                                            style: const TextStyle(fontSize: 14, color: Colors.black),
                                          ),
                                          Text(
                                            "${addr.city ?? ''} - ${addr.pinCode ?? ''}",
                                            style: const TextStyle(fontSize: 14, color: Colors.black),
                                          ),
                                          Text(
                                            "📞 ${addr.mobileNo ?? ''}",
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
        ],
      );
    }),
    bottomNavigationBar: Obx(() {
      final isReadyToBook = addressController.selectedAddressIndex.value != -1 &&
          repairController.totalPrice.value > 0 &&
          repairController.selectedServices.isNotEmpty;

      return Container(
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
                  "₹${repairController.totalPrice.value}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Apply Coupon",
                  style: TextStyle(fontSize: 12, color: ColorConstants.appBlueColor3),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: isReadyToBook
                  ? () async {
                      final selectedIndex = addressController.selectedAddressIndex.value;
                      final selectedAddressToSend = addressController.addressList[selectedIndex];
                      final customerId = await TokenHelper.getUserCode();

                      if (customerId == null || customerId.isEmpty) {
                        Get.snackbar('Error', 'User not logged in',
                            backgroundColor: Colors.red, colorText: Colors.white);
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RepairDateSelectorScreen(
                            customerId: customerId,
                            brandId: brandId,
                            modelId: modelId,
                            colorId: colorId,
                            totalPrice: totalPrice,
                            selectedAddress: selectedAddressToSend,
                            selectedServices: selectedServices,
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isReadyToBook ? ColorConstants.appBlueColor3 : Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
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
      );
    }),
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
                padding: const EdgeInsets.symmetric(vertical: 5),
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
}
