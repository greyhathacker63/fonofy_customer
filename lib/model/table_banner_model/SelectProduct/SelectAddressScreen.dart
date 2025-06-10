import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/Manage%20Address/AddNewAddressScreen.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/ShippingAddressModel/ListShippingAddressModel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';
import '../../../controllers/ControllerProductDetails/AddressRepairController.dart';
import '../../../controllers/ControllerProductDetails/ControllerProductDetails.dart';
import '../../../controllers/RepairController/RepairBookingController.dart';
import '../../../controllers/RepairController/RepairServicesTableController.dart';
import '../../RepairModel/RepairBookingModel.dart';
import 'ThankYouRepairScreen.dart';

class SelectRepairAddressScreen extends StatelessWidget {
  const SelectRepairAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressRepairController addressController = Get.put(AddressRepairController());
    final RepairControllerTable repairController = Get.find<RepairControllerTable>();
    final RepairBookingController bookingController = Get.put(RepairBookingController());
    final ControllerProductDetails productController = Get.put(ControllerProductDetails());

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

    void _bookRepair() async {
      if (addressController.selectedAddressIndex.value == -1 ||
          addressController.selectedAddressIndex.value >= addressController.addressList.length) {
        Get.snackbar('Error', 'Please select an address',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      final selectedAddress = addressController.addressList[addressController.selectedAddressIndex.value];
      final token = await TokenHelper.getToken();
      final customerId = await TokenHelper.getUserCode();

      // Validate critical inputs
      if (token == null || token.isEmpty) {
        Get.snackbar('Error', 'Authentication token not found',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
      if (customerId == null || customerId.isEmpty) {
        Get.snackbar('Error', 'Customer ID not found',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
      if (selectedAddress.id == null || selectedAddress.name == null || selectedAddress.address == null) {
        Get.snackbar('Error', 'Invalid address details',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
      if (repairController.selectedServices.isEmpty) {
        Get.snackbar('Error', 'No repair services selected',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }


      try {
        // Calculate totals for consistency
        final totalAmount = repairController.selectedServices.fold<double>(
          0.0,
              (sum, service) => sum + (service.price ?? 0.0),
        );
        final totalDiscount = repairController.selectedServices.fold<double>(
          0.0,
              (sum, service) => sum + (service.discountAmount ?? 0.0),
        );
        final totalMrp = totalAmount;
        final totalPrice = totalAmount - totalDiscount;

        final orderId = const Uuid().v4(); // Generate unique orderId

        final bookingModel = RepairBookingModel(
          modelId: productController.productDetails.value?.modelNo ?? '',
          romId: productController.productDetails.value?.romId ?? '',
          ramId: productController.productDetails.value?.ramId ?? '',
          colorId: productController.productDetails.value?.colorId ?? '',
          customerId: customerId,
          orderId: orderId,

          couponId: '',
          shippingId: selectedAddress.shippmentId ?? '',
          shippingName: selectedAddress.name ?? '',
          shippingMobileNo: selectedAddress.mobileNo ?? '',
          shippingEmailId: selectedAddress.emailId ?? '',
          shippingAddress: selectedAddress.address ?? '',
          shippingLandmark: selectedAddress.address ?? '',
          shippingCity: selectedAddress.city ?? '',
          shippingState: selectedAddress.state ?? '',
          shippingPincode: selectedAddress.pinCode ?? '',
          workType: selectedAddress.workType ?? '',
          couponName: selectedAddress.workType ?? '',
          couponDiscountType: 'sdf',
          couponAmount: '21.0',
          couponPercent: '22.0',
          couponCode: 'sdsf',
          repairType: 'battery',
          slotDate: '06-06-2025',
          remark: '',
          deliveryCharge: '1.0',
          totalAmount: totalAmount.toString(),
          totalPrice: totalPrice.toString(),
          totalDiscount: totalDiscount.toString(),
          totalMrp: totalMrp.toString(),
          mode: 'Online',
          repairDetails: repairController.selectedServices.map((service) {
            return RepairDetail(
              customerId: customerId,
              orderId: orderId, // Use same orderId for consistency
              serviceId: service.id ?? 0,
              serviceName: service.serviceName ?? 'Unknown Service',
              serviceAmount: (service.price ?? 0.0).toInt(),
              serviceDiscount: (service.discountAmount ?? 0.0).toInt(),
              servicePercent: 0,
            );
          }).toList(), servieCharge: null,
        );

        // Log the booking model for debugging
        print('Booking Model: ${bookingModel.toJson()}');

        await bookingController.bookRepair(bookingModel, token);
        if (bookingController.isBooked.value) {
          Get.off(() => ThankYouRepairScreen());
        } else {
          Get.snackbar('Error', 'Booking failed. Please check your inputs.',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to book repair: $e',
            backgroundColor: Colors.red, colorText: Colors.white);
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
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Address", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Text("Time Slot", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black45)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appBlueColor3,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _navigateToAddNewAddressScreen,
                  child: Text(
                    "+ Add New Address",
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
                  child: Text("No addresses available"),
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
                                    "${address.name ?? 'Unknown'} | ${address.workType ?? ''}",
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
                                    "📞 ${address.mobileNo ?? 'N/A'}",
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
            if (bookingController.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator()),
              ),
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
                  const Text(
                    "Apply Coupon",
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addressController.selectedAddressIndex.value != -1 &&
                      repairController.totalPrice.value > 0 &&
                      repairController.selectedServices.isNotEmpty &&
                      repairController.selectedServices.value.isNotEmpty
                      ? ColorConstants.appBlueColor3
                      : Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: addressController.selectedAddressIndex.value != -1 &&
                    repairController.totalPrice.value > 0 &&
                    repairController.selectedServices.isNotEmpty &&
                    repairController.selectedServices.value.isNotEmpty
                    ? _bookRepair
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