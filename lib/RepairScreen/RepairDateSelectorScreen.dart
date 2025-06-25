import 'package:flutter/material.dart';
import 'package:fonofy/controllers/RepairController/RepairServicesTableController.dart';
import 'package:fonofy/controllers/ControllerProductDetails/ControllerProductDetails.dart';
import 'package:fonofy/controllers/RepairController/RepairBookingController.dart';
import 'package:fonofy/model/RepairModel/BookingRepairModel.dart';
import 'package:fonofy/model/RepairModel/RepairServicesTableModel.dart';
import 'package:fonofy/model/ShippingAddressModel/ListShippingAddressModel.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/ControllerProductDetails/AddressRepairController.dart';
import '../model/table_banner_model/SelectProduct/ThankYouRepairScreen.dart';

// class RepairDateSelectorScreen extends StatefulWidget {
//   final String? customerId;
//   final String? brandId;
//   final String? productId;
//   final String? colorId;
//   final dynamic totalPrice;
//  final List<Table1> selectedServices;

//   final ListShippingAddressModel selectedAddress;
//   const RepairDateSelectorScreen({
//     Key? key,
//     required this.customerId,
//     required this.brandId,
//     required this.productId,
//     required this.colorId,
//     required this.totalPrice,
//     required this.selectedServices,
//     required this.selectedAddress,
//   }) : super(key: key);

//   @override
//   _RepairDateSelectorScreenState createState() => _RepairDateSelectorScreenState();
// }

// class _RepairDateSelectorScreenState extends State<RepairDateSelectorScreen> {
//   int selectedIndex = 0;

//   final RepairControllerTable repairController = Get.find();

//   // final ControllerProductDetails controllerProductDetails = Get.find();

//   final RepairBookingController bookingController = Get.put(RepairBookingController());

//   final ControllerProductDetails controllerProductDetails = Get.put(ControllerProductDetails());

//   final AddressRepairController controllerAddressRepairDetails = Get.find<AddressRepairController>();

//   List<DateTime> getNext7Days() {
//     return List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<DateTime> dateList = getNext7Days();

//     return Scaffold(
//       appBar: AppBar(title: const Text("Select Date")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Choose preferred date for repair expert to visit you",
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 20),
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: dateList.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 childAspectRatio: 1.1,
//                 crossAxisSpacing: 7,
//                 mainAxisSpacing: 7,
//               ),
//               itemBuilder: (context, index) {
//                 final date = dateList[index];
//                 final isSelected = selectedIndex == index;
//                 final label = index == 0
//                     ? "TODAY"
//                     : index == 1
//                     ? "TOMORROW"
//                     : null;

//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = index;
//                     });
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: isSelected ? ColorConstants.appBlueColor3 : Colors.white,
//                       border: Border.all(color: ColorConstants.appBlueColor3),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.shade200,
//                           blurRadius: 4,
//                           offset: const Offset(0, 2),
//                         )
//                       ],
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         if (label != null)
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                             decoration: BoxDecoration(
//                               color: ColorConstants.appBlueColor3,
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: Text(
//                               label,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         const SizedBox(height: 8),
//                         Text(
//                           DateFormat('dd').format(date),
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: isSelected ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           DateFormat('EEEE').format(date),
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: isSelected ? Colors.white : Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           border: Border(top: BorderSide(color: Colors.black12)),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "₹${repairController.totalPrice.value}",
//                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "Show Price Breakup",
//                     style: TextStyle(fontSize: 12, color: ColorConstants.appBlueColor3),
//                   ),
//                 ],
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 backgroundColor: ColorConstants.appBlueColor3,
//               ),
//               // In RepairDateSelectorScreen, inside the ElevatedButton's onPressed:
//               onPressed: () async {
//                 final selectedDate = DateFormat('yyyy-MM-dd').format(dateList[selectedIndex]);

//                 // Validate required fields
//                 if (controllerProductDetails.productDetails.value == null ||
//                     controllerAddressRepairDetails.addressRepair.value == null) {
//                   Get.snackbar('Error', 'Device or address details missing',
//                       backgroundColor: Colors.red, colorText: Colors.white);
//                   return;
//                 }

//                 // Map selected services to RepairDetail objects
//                 final repairDetails = repairController.selectedServices.value.map((service) {
//                   return RepairDetail(
//                       customerId: '',
//                       orderId: '',
//                       serviceId: null,
//                       serviceName: '',
//                       serviceAmount: null,
//                       serviceDiscount: null,
//                       servicePercent: null
//                    );
//                 }).toList();

//                 if (repairDetails.isEmpty) {
//                   Get.snackbar('Error', 'No services selected',
//                       backgroundColor: Colors.red, colorText: Colors.white);
//                   return;
//                 }
//                 print('Submitting booking with:');
//                 print('ModelId: ${controllerProductDetails.productDetails.value?.modelNo}');
//                 print('ShippingId: ${controllerAddressRepairDetails.addressRepair.value?.shippmentId}');
//                 print('RepairDetails: ${repairDetails.map((e) => e.toJson()).toList()}');

//                 await bookingController.submitRepairBooking(
//                   modelId: controllerProductDetails.productDetails.value?.modelNo,
//                   romId: controllerProductDetails.productDetails.value?.romId ?? '',
//                   ramId: controllerProductDetails.productDetails.value?.ramId ?? '',
//                   colorId: controllerProductDetails.productDetails.value?.colorId ?? '',
//                   customerId: controllerAddressRepairDetails.addressRepair.value?.customerId ?? '',
//                   shippingName: controllerAddressRepairDetails.addressRepair.value?.name ?? '',
//                   shippingId: controllerAddressRepairDetails.addressRepair.value?.shippmentId ?? '',
//                   shippingMobileNo: controllerAddressRepairDetails.addressRepair.value?.mobileNo ?? '',
//                   shippingEmailId: controllerAddressRepairDetails.addressRepair.value?.emailId ?? '',
//                   shippingAddress: controllerAddressRepairDetails.addressRepair.value?.address ?? '',
//                   shippingLandmark: controllerAddressRepairDetails.addressRepair.value?.address ?? '',
//                   shippingCity: controllerAddressRepairDetails.addressRepair.value?.city ?? '',
//                   shippingState: controllerAddressRepairDetails.addressRepair.value?.state ?? '',
//                   shippingPincode: controllerAddressRepairDetails.addressRepair.value?.pinCode ?? '',
//                   workType: controllerAddressRepairDetails.addressRepair.value?.workType ?? '',
//                   totalMRP: repairController.totalPrice.value.toDouble(),
//                   totalPrice: repairController.totalPrice.value.toDouble(),
//                   totalAmount: repairController.totalPrice.value.toDouble(),
//                   totalDiscount: 0.0, // Adjust based on your discount logic
//                   deliveryCharge: 0.0,
//                   couponId: null,
//                   couponName: '',
//                   couponDiscountType: '',
//                   couponAmount: 0.0,
//                   couponPercent: 0.0,
//                   couponCode: '',
//                   repairType: 'Home',
//                   slotDate: selectedDate,
//                   remark: 'Please be on time',
//                   repairDetails: repairDetails,
//                 );
//                 if (!bookingController.isLoading.value) {
//                   Get.off(() => ThankYouRepairScreen());
//                 }
//               },
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 8),
//                     child: Text("Place Order", style: TextStyle(fontSize: 16, color: Colors.white)),
//                   ),
//                   SizedBox(width: 8),
//                   Icon(Icons.arrow_forward, color: Colors.white, size: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class RepairDateSelectorScreen extends StatefulWidget {
  final String? customerId;
  final String? brandId;
  final String? modelId;
  final String? colorId;
  final dynamic totalPrice;
  final List<Table1> selectedServices;
  final ListShippingAddressModel selectedAddress;

  const RepairDateSelectorScreen({
    Key? key,
    required this.customerId,
    required this.brandId,
    required this.modelId,
    required this.colorId,
    required this.totalPrice,
    required this.selectedAddress,
    required this.selectedServices,
  }) : super(key: key);

  @override
  _RepairDateSelectorScreenState createState() =>
      _RepairDateSelectorScreenState();
}

class _RepairDateSelectorScreenState extends State<RepairDateSelectorScreen> {
  int selectedIndex = 0;

  final RepairControllerTable repairController = Get.find();
  final RepairBookingController bookingController =
      Get.put(RepairBookingController());

  List<DateTime> getNext7Days() =>
      List.generate(7, (index) => DateTime.now().add(Duration(days: index)));

  @override
  Widget build(BuildContext context) {
    final List<DateTime> dateList = getNext7Days();

    return Scaffold(
      appBar: AppBar(title: const Text("Select Date")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose preferred date for repair expert to visit you",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dateList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.1,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
              ),
              itemBuilder: (context, index) {
                final date = dateList[index];
                final isSelected = selectedIndex == index;
                final label = index == 0
                    ? "TODAY"
                    : index == 1
                        ? "TOMORROW"
                        : null;

                return GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorConstants.appBlueColor3
                          : Colors.white,
                      border: Border.all(color: ColorConstants.appBlueColor3),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (label != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: ColorConstants.appBlueColor3,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(label,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat('dd').format(date),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('EEEE').format(date),
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("₹${repairController.totalPrice.value}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Show Price Breakup",
                      style: TextStyle(
                          fontSize: 12, color: ColorConstants.appBlueColor3)),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: ColorConstants.appBlueColor3,
              ),
              onPressed: () async {
                final selectedDate =
                    DateFormat('dd-MM-yyyy').format(dateList[selectedIndex]);

                if (widget.selectedServices.isEmpty) {
                  Get.snackbar('Error', 'No services selected',
                      backgroundColor: Colors.red, colorText: Colors.white);
                  return;
                }

                print("=== SUBMITTING BOOKING ===");
                print("modelId: ${widget.modelId}");
                print("romId: 2");
                print("ramId: 3");
                print("colorId: 5");

                print("customerId: ${widget.customerId}");
                print("shippingId: ${widget.selectedAddress.shippmentId}");
                print("shippingName: ${widget.selectedAddress.name}");
                print("shippingMobileNo: ${widget.selectedAddress.mobileNo}");
                print("shippingEmailId: ${widget.selectedAddress.emailId}");
                print("shippingAddress: ${widget.selectedAddress.address}");
                print("shippingLandmark: ${widget.selectedAddress.address}");
                print("shippingCity: ${widget.selectedAddress.address}");
                print("shippingState: ${widget.selectedAddress.address}");
                print("shippingPincode: ${widget.selectedAddress.pinCode}");
                print("workType: ${widget.selectedAddress.workType}");

                print("couponId: 1");
                print("couponName: Home");
                print("couponDiscountType: sdf");
                print("couponAmount: 21.0");
                print("couponPercent: 22.0");
                print("couponCode: sdsf");

                print("servieCharge: 7.0");
                print("deliveryCharge: 1.0");
                print("totalMRP: ${widget.totalPrice}");
                print("totalPrice: ${widget.totalPrice}");
                print("totalAmount: ${widget.totalPrice}");
                print("totalDiscount: 7000");
                print("mode: ds");

                print("repairType: sample string 24");
                print("slotDate: $selectedDate");
                print("slotTime: ''");
                print("remark: Please be on time");

                print("repairDetails:");
                widget.selectedServices.forEach((service) {
                  print("  - serviceId: ${service.serviceId}");
                  print("    serviceName: ${service.serviceName}");
                  print("    serviceAmount: ${widget.totalPrice}");
                  print("    serviceDiscount: ${widget.totalPrice}");
                  print("    servicePercent: ${widget.totalPrice}");
                });

                try {
                  await bookingController.submitRepairBooking(
                    modelId: widget.modelId?.toString() ?? '',
                    romId: 2.toString(),
                    ramId: 3.toString(),
                    colorId: widget.colorId,
                    customerId: widget.customerId ?? '',
                    shippingId: widget.selectedAddress.shippmentId ?? '',
                    shippingName: widget.selectedAddress.name ?? '',
                    shippingMobileNo: widget.selectedAddress.mobileNo ?? '',
                    shippingEmailId: widget.selectedAddress.emailId ?? '',
                    shippingAddress: widget.selectedAddress.address ?? '',
                    shippingLandmark: widget.selectedAddress.address ?? '',
                    shippingCity: widget.selectedAddress.city ?? '',
                    shippingState: widget.selectedAddress.state ?? '',
                    shippingPincode: widget.selectedAddress.pinCode ?? '',
                    workType: widget.selectedAddress.workType ?? '',
                    couponId: 1.toString(),
                    couponName: "Home",
                    couponDiscountType: "sdf",
                    couponAmount: 21.0,
                    couponPercent: 22.0,
                    couponCode: "sdsf",
                    servieCharge: 7.0,
                    deliveryCharge: 1.0,
                    totalMRP: (widget.totalPrice as num?)?.toDouble() ?? 0.0,
                    totalPrice: (widget.totalPrice as num?)?.toDouble() ?? 0.0,
                    totalAmount: (widget.totalPrice as num?)?.toDouble() ?? 0.0,
                    totalDiscount: (7000).toDouble(),
                    Mode: "ds",
                    repairType: "sample string 24",
                    slotDate: selectedDate,
                    slotTime: '',
                    remark: 'Please be on time',
                    repairDetails: widget.selectedServices.map((service) {
                      return RepairDetail(
                        customerId: widget.customerId ?? '',
                        orderId: "Ord_11052025011028871",
                        serviceId: service.serviceId ?? 0,
                        serviceName: service.serviceName ?? '',
                        serviceAmount:
                            (service.serviceAmount as num?)?.toDouble() ?? 0.0,
                        serviceDiscount:
                            (service.discountAmount as num?)?.toDouble() ?? 0.0,
                        servicePercent:
                            (service.disPercentage as num?)?.toDouble() ?? 0.0,
                      );
                    }).toList(),
                  );
                } catch (e) {
                  print("Error while booking: $e");
                }

                // repairDetails: widget.selectedServices.map((service) {
                //   return RepairDetail(
                //     customerId: widget.customerId ?? '',
                //     orderId: "Ord_11052025011028871",
                //     serviceId: service.serviceId ?? 0,
                //     serviceName: service.serviceName ?? '',
                //     serviceAmount:
                //         (service.serviceAmount as num?)?.toDouble() ?? 0.0,
                //     serviceDiscount: 6.0,
                //     servicePercent: 7.0,
                //   );

                //   Get.snackbar("Success", "Repair booking submitted!",
                //       backgroundColor: Colors.green, colorText: Colors.white);
                // } catch (e) {
                //   print('Booking failed: $e');
                //   Get.snackbar("Error", "Booking submission failed",
                //       backgroundColor: Colors.red, colorText: Colors.white);
                // }
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text("Place Order",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
