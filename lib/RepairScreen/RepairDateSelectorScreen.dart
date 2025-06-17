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
//             const Text(
//               "Choose preferred date for repair expert to visit you",
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../TokenHelper/TokenHelper.dart';
import '../controllers/ControllerProductDetails/ControllerProductDetails.dart';
import '../controllers/OrderController/TrackOrderController.dart';
import '../controllers/RepairController/RepairBookingController.dart';
import '../controllers/RepairController/RepairServicesTableController.dart';
import '../model/RepairModel/RepairBookingModel.dart';
import '../model/table_banner_model/SelectProduct/ThankYouRepairScreen.dart';
import '../utils/Colors.dart';

class RepairDateSelectorScreen extends StatefulWidget {
  const RepairDateSelectorScreen({super.key});

  @override
  _RepairDateSelectorScreenState createState() =>
      _RepairDateSelectorScreenState();
}

class _RepairDateSelectorScreenState extends State<RepairDateSelectorScreen> {
  int selectedIndex = 0;
  String? userCode;

  final repairController = Get.find<RepairControllerTable>();
  final productControllerDetails = Get.put(ControllerProductDetails());
  final TrackingController trackingController = Get.find<TrackingController>();
  final bookingController = Get.put(RepairBookingController());

  List<DateTime> getNext7Days() {
    return List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
  }

  @override
  void initState() {
    super.initState();
    _loadUserCode();
    bookingController.isLoading;
  }

  Future<void> _loadUserCode() async {
    userCode = await TokenHelper.getUserCode();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> dateList = getNext7Days();

    return Scaffold(
      appBar: AppBar(title: const Text("Select Date")),
      body: userCode == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                    ),
                    itemBuilder: (context, index) {
                      final date = dateList[index];
                      final isSelected = selectedIndex == index;
                      final label = index == 0 ? "TODAY" : index == 1 ? "TOMORROW" : null;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ColorConstants.appBlueColor3
                                : Colors.white,
                            border:
                                Border.all(color: ColorConstants.appBlueColor3),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 4,
                                offset:  Offset(0, 2),
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(vertical: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (label != null)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
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
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('EEEE').format(date),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black87,
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
        child: Obx(() {
          return Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "₹${repairController.totalPrice.value}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Show Price Breakup",
                      style: TextStyle(
                          fontSize: 12, color: ColorConstants.appBlueColor3),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: ColorConstants.appBlueColor3,
                ),
                onPressed: bookingController.isLoading.value
                    ? null
                    : () async {
                        final selectedDate = dateList[selectedIndex];
                        final formattedDate =
                            DateFormat('yyyy-MM-dd').format(selectedDate);

                        await bookingController.submitRepairBooking(
                          modelId: productControllerDetails.productDetails.value?.modelNo ?? '',
                          romId: productControllerDetails.productDetails.value?.romId ?? '',
                          ramId: productControllerDetails.productDetails.value?.ramId ?? '',
                          colorId: productControllerDetails.productDetails.value?.colorId ?? '',
                          customerId: userCode ?? '',
                          shippingId: trackingController.trackingData.value?.shippingId ?? '',
                          shippingName: trackingController.trackingData.value?.shippingName ?? '',
                          shippingMobileNo: trackingController.trackingData.value?.shippingMobileNo ?? '',
                          shippingEmailId: trackingController.trackingData.value?.shippingEmailId ?? '',
                          shippingAddress: trackingController.trackingData.value?.shippingAddress ?? '',
                          shippingLandmark: trackingController.trackingData.value?.shippingLandmark ??'',
                          shippingCity: trackingController.trackingData.value?.shippingCity ?? '',
                          shippingState: trackingController.trackingData.value?.shippingState ??'',
                          shippingPincode: trackingController.trackingData.value?.shippingPincode ?? '',
                          workType: trackingController.trackingData.value?.workType ?? '',
                          totalMRP: trackingController.trackingData.value?.totalMrp ?? 0,
                          totalPrice: trackingController.trackingData.value?.totalPrice ?? 0,
                          totalAmount: trackingController.trackingData.value?.totalAmount ?? 0,
                          totalDiscount: trackingController.trackingData.value?.totalDiscount ?? 0,
                          deliveryCharge: trackingController.trackingData.value?.deliveryCharge ?? 0,
                          couponId: '',
                          couponName: '',
                          couponDiscountType: '',
                          couponAmount: 0,
                          couponPercent: 0,
                          couponCode: '',
                          repairType: '',
                          slotDate: formattedDate,
                          remark: '',
                          paymentMode: '',
                          repairDetails:
                              repairController.selectedServices.map((service) {
                            return RepairDetail(
                                customerId: userCode.toString(),
                                orderId: trackingController.trackingData.value?.orderId ?? '',
                                serviceId: null,
                                serviceName: '',
                                serviceAmount: trackingController.trackingData.value?.totalAmount ?? '',
                                serviceDiscount: trackingController.trackingData.value?.totalDiscount ?? '',
                                servicePercent: null,
                            );
                          }).toList(),
                        );

                        if (!bookingController.isLoading.value) {
                          Get.off(() => ThankYouRepairScreen());
                        }
                      },
                child: bookingController.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,)
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Place Order", style: TextStyle(fontSize: 16, color: Colors.white)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward,
                              color: Colors.white, size: 20,
                          ),
                        ],
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
