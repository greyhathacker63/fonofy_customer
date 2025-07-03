import 'package:flutter/material.dart';
import 'package:fonofy/YourDevice/SelectPickupSlot.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../Manage Address/AddNewAddressScreen.dart';
import '../TokenHelper/TokenHelper.dart';
import '../controllers/ControllerProductDetails/AddressRepairController.dart';
import '../model/ShippingAddressModel/ListShippingAddressModel.dart';

class YourDeviceScreen2 extends StatefulWidget {
  final double finalPrice;
  final String baseprice;
  final String? pid;
  final String bid;
  final String raid;
  final String roid;
  final String? selectedVariant;
  final String modelNo;
  final String ram;
  final String rom;
  final String modelName;
  final List finalhPageAns;

  const YourDeviceScreen2({
    super.key,
    required this.finalPrice,
    required this.baseprice,
    this.pid,
    required this.bid,
    required this.raid,
    required this.roid,
    this.selectedVariant,
    required this.modelNo,
    required this.ram,
    required this.rom,
    required this.modelName,
    required this.finalhPageAns,
  });

  @override
  State<YourDeviceScreen2> createState() => _YourDeviceScreen2State();
}

class _YourDeviceScreen2State extends State<YourDeviceScreen2> {
  final AddressRepairController addressController = Get.put(AddressRepairController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addressController.fetchAddresses();
    });
  }

  void _navigateToAddNewAddressScreen() async {
    String? customerId = await TokenHelper.getUserCode();
    if (customerId == null || customerId.isEmpty) {
      Get.snackbar('Error', 'User not logged in', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final dataSell = await Get.to(() => AddNewAddressScreen(
          customerId: customerId,
          address: ListShippingAddressModel(),
        ));

    if (dataSell == true) {
      addressController.fetchAddresses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Your Device", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStepBox("1", "Address", isActive: true),
                  _buildDivider(),
                  _buildStepBox("2", "Pickup Slot"),
                  _buildDivider(),
                  _buildStepBox("3", "Payment"),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Image.asset("assets/images/location.png", height: 30),
                  const SizedBox(width: 10),
                  const Text("Use My Current Location", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appBlueColor3,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _navigateToAddNewAddressScreen,
                  child: const Text("+ Add New Address", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (addressController.isLoading.value) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (_, __) => _buildShimmerEffect(),
                  );
                } else if (addressController.addressList.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("No address available"),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: addressController.addressList.length,
                    itemBuilder: (context, index) {
                      final address = addressController.addressList[index];
                      return Obx(() {
                        final isSelected = addressController.selectedAddressIndex.value == index;
                        return InkWell(
                          onTap: () => addressController.selectAddress(index),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: isSelected ? ColorConstants.appBlueColor3 : Colors.black12,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${address.name ?? ' '} | ${address.workType ?? ''}",
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text(address.address ?? "No address provided", style: const TextStyle(fontSize: 14)),
                                  Text("${address.city ?? ''} - ${address.pinCode ?? ''}",
                                      style: const TextStyle(fontSize: 14)),
                                  Text("📞 ${address.mobileNo ?? ''}", style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  );
                }
              }),
              const SizedBox(height: 250),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appBlueColor3,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    if (addressController.selectedAddressIndex.value == -1) {
                      Get.snackbar(
                        'No Address Selected',
                        'Please select an address before continuing.',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else {
                      final selected = addressController.addressList[addressController.selectedAddressIndex.value];
                      Get.to(() => PickupSlotPage(
                            shippingId: selected.id.toString(),
                            shippingName: selected.name ?? '',
                            shippingMobileNo: selected.mobileNo ?? '',
                            shippingEmailId: selected.emailId ?? '',
                            shippingAddress: selected.address ?? '',
                            shippingLandmark: selected.city ?? '',
                            shippingCity: selected.city.toString(),
                            shippingState: selected.state.toString(),
                            shippingPincode: selected.pinCode ?? '',
                            workType: selected.workType ?? '',
                            finalPrice: widget.finalPrice.toString(),
                            baseprice: widget.baseprice,
                            pid: widget.pid.toString(),
                            bid: widget.bid,
                            raid: widget.raid,
                            roid: widget.roid,
                            selectedVariant: widget.selectedVariant.toString(),
                            modelNo: widget.modelNo,
                            ram: widget.ram,
                            rom: widget.rom,
                            modelName: widget.modelName,
                            finalhPageAns: widget.finalhPageAns,
                          ));
                    }
                  },
                  child: Text("Continue", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepBox(String number, String title, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.grey.shade300,
            border: Border.all(color: isActive ? Colors.blue : Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            number,
            style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? Colors.blue : Colors.black),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isActive ? Colors.black : Colors.black54),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey.shade300,
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


  