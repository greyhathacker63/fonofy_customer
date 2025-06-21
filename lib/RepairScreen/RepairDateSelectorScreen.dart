// import 'package:flutter/material.dart';
// import 'package:fonofy/controllers/product_controller.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
//  import '../controllers/ControllerProductDetails/ControllerProductDetails.dart';
// import '../controllers/RepairController/RepairServicesTableController.dart';
// import '../model/table_banner_model/SelectProduct/ThankYouRepairScreen.dart';
// import '../utils/Colors.dart';
//
// class RepairDateSelectorScreen extends StatefulWidget {
//   const RepairDateSelectorScreen({super.key});
//
//   @override
//   _RepairDateSelectorScreenState createState() => _RepairDateSelectorScreenState();
// }
//
// class _RepairDateSelectorScreenState extends State<RepairDateSelectorScreen> {
//
//
//   int selectedIndex = 0;
//
//   final RepairControllerTable repairController = Get.find<RepairControllerTable>();
//
//   final ControllerProductDetails productDetails = Get.put(ControllerProductDetails());
//
//   final TrackingScrollController trackingScrollController = Get.put(TrackingScrollController());
//
//   List<DateTime> getNext7Days() {
//     return List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final List<DateTime> dateList = getNext7Days();
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Select Date")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Choose preferred date for repair expert to visit you",
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 20),
//             GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: dateList.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
//
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
//                           offset: Offset(0, 2),
//                         )
//                       ],
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 0),
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
//                               style: TextStyle(
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
//                         SizedBox(height: 4),
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
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration:   BoxDecoration(
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
//                   Text(repairController.totalPrice.value > 0
//                         ? "₹${repairController.totalPrice.value}"
//                         : "₹0",
//                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "Show Price Breakup",
//                     style: TextStyle(fontSize: 12, color: ColorConstants.appBlueColor3),
//                   ),
//
//                 ],
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 backgroundColor: ColorConstants.appBlueColor3,
//               ),
//               onPressed: () {
//                 Get.off(()=>ThankYouRepairScreen());
//                 // final selectedDate = dateList[selectedIndex];
//                 // Navigator.pop(context, selectedDate); // Return selected date to previous screen
//               },
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
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
//
//
//
//
//
//
//


import 'package:flutter/material.dart';
import 'package:fonofy/controllers/RepairController/RepairServicesTableController.dart';
import 'package:fonofy/controllers/ControllerProductDetails/ControllerProductDetails.dart';
import 'package:fonofy/controllers/RepairController/RepairBookingController.dart';
import 'package:fonofy/model/RepairModel/RepairBookingModel.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/ControllerProductDetails/AddressRepairController.dart';
import '../model/table_banner_model/SelectProduct/ThankYouRepairScreen.dart';

class RepairDateSelectorScreen extends StatefulWidget {
  const RepairDateSelectorScreen({super.key});

  @override
  _RepairDateSelectorScreenState createState() => _RepairDateSelectorScreenState();
}

class _RepairDateSelectorScreenState extends State<RepairDateSelectorScreen> {
  int selectedIndex = 0;

  final RepairControllerTable repairController = Get.find();

  // final ControllerProductDetails controllerProductDetails = Get.find();

  final RepairBookingController bookingController = Get.put(RepairBookingController());
  final ControllerProductDetails controllerProductDetails = Get.put(ControllerProductDetails());

  final AddressRepairController controllerAddressRepairDetails = Get.find<AddressRepairController>();

  List<DateTime> getNext7Days() {
    return List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
  }

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
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? ColorConstants.appBlueColor3 : Colors.white,
                      border: Border.all(color: ColorConstants.appBlueColor3),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (label != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: ColorConstants.appBlueColor3,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
                  Text(
                    "₹${repairController.totalPrice.value}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Show Price Breakup",
                    style: TextStyle(fontSize: 12, color: ColorConstants.appBlueColor3),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: ColorConstants.appBlueColor3,
              ),
              onPressed: () async {
                final selectedDate = DateFormat('yyyy-MM-dd').format(dateList[selectedIndex]);

                await bookingController.submitRepairBooking(
                  modelId: controllerProductDetails.productDetails.value?.modelNo ?? '',
                  romId: controllerProductDetails.productDetails.value?.romId ?? '',
                  ramId: controllerProductDetails.productDetails.value?.ramId ?? '',
                  colorId: controllerProductDetails.productDetails.value?.colorId ?? '',
                  customerId: controllerAddressRepairDetails.addressRepair.value?. customerId ??'', // Replace this
                  shippingName:controllerAddressRepairDetails.addressRepair.value?.name ?? '',
                  shippingId: controllerAddressRepairDetails.addressRepair.value?.shippmentId ?? '',
                  shippingMobileNo: controllerAddressRepairDetails.addressRepair.value?.mobileNo ?? '',
                  shippingEmailId: controllerAddressRepairDetails.addressRepair.value?.emailId ?? '',
                  shippingAddress: controllerAddressRepairDetails.addressRepair.value?.address ?? '',
                  shippingLandmark: controllerAddressRepairDetails.addressRepair.value?.address ?? '',
                  shippingCity: controllerAddressRepairDetails.addressRepair.value?.city ?? '',
                  shippingState: controllerAddressRepairDetails.addressRepair.value?.state ?? '',
                  shippingPincode: controllerAddressRepairDetails.addressRepair.value?.pinCode ?? '',
                  workType: controllerAddressRepairDetails.addressRepair.value?.workType ?? '',
                  totalMRP: bookingController.bookingDetails.value?.totalMrp ?? '',
                  totalPrice: bookingController.bookingDetails.value?.totalPrice ?? '',
                  totalAmount: bookingController.bookingDetails.value?.totalAmount ?? '',
                  totalDiscount: bookingController.bookingDetails.value?.totalDiscount ?? '',
                  deliveryCharge: 0,
                  couponId: null,
                  couponName: '',
                  couponDiscountType: '',
                  couponAmount: 0,
                  couponPercent: 0,
                  couponCode: '',
                  repairType: 'Home',
                  slotDate: selectedDate,
                  remark: 'Please be on time', repairDetails: [],
                  // repairDetails:,
                );

                if (!bookingController.isLoading.value) {
                  Get.off(() => ThankYouRepairScreen());
                }
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text("Place Order", style: TextStyle(fontSize: 16, color: Colors.white)),
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

