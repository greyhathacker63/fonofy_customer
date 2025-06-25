import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/Manage%20Address/AddNewAddressScreen.dart';
import 'package:fonofy/model/RepairModel/BookingRepairModel.dart';
import 'package:fonofy/model/RepairModel/RepairServicesTableModel.dart';
import 'package:get/get.dart';
import '../controllers/RepairController/RepairServicesTableController.dart';
import '../model/table_banner_model/SelectProduct/SelectAddressScreen.dart';
import '../widgets/RepairWidets/BookNowButton.dart';
import '../widgets/RepairWidets/DevicePhoneInfoCard.dart';
import '../widgets/RepairWidets/FeatureColumn.dart';
import '../widgets/RepairWidets/OtherRepairTile.dart';
import '../widgets/RepairWidets/ServicePhoneItem.dart';
import '../widgets/RepairWidets/StatsColumn.dart';

// class SelectServicesScreen extends StatefulWidget {
//   final String brandId;
//   final String productId;
//   final String colorId;

//   const SelectServicesScreen({
//     super.key,
//     required this.brandId,
//     required this.productId,
//     required this.colorId,
//   });

//   @override
//   _SelectServicesScreenState createState() => _SelectServicesScreenState();
// }

// class _SelectServicesScreenState extends State<SelectServicesScreen> {
//   final RepairControllerTable repairController =
//       Get.put(RepairControllerTable());

//   @override
//   void initState() {
//     super.initState();
//     repairController.getTableRepairData(
//         widget.brandId, widget.productId, widget.colorId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Select Services"),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0.5,
//         leading: const BackButton(),
//       ),
//       body: Obx(
//         () => repairController.isRepairTableLoading.value
//             ? const Center(
//                 child: CircularProgressIndicator(
//                     strokeWidth: 2, color: Colors.blue))
//             : SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // Device Info
//                     if (repairController.tableRepairData?.table?.isNotEmpty ??
//                         false)
//                       DevicePhoneInfoCard(
//                           repairTable: repairController.tableRepairData?.table)
//                     else
//                       const Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text("No device data available"),
//                       ),
//                     // Services List
//                     if (repairController.tableRepairData?.table1?.isNotEmpty ??
//                         false)
//                       ...repairController.tableRepairData!.table1!.map(
//                         (service) => ServicePhoneItem(
//                           image: "$imageAllBaseUrl${service.serviceImage}",
//                           title: service.serviceName ?? "",
//                           discount: (service.disPercentage ?? 0).toInt(),
//                           price: (service.price ?? 0).toInt(),
//                           mrp: (service.mrp ?? 0).toInt(),
//                           note: service.id == 0
//                               ? "This ₹99 is only for inspection. Final repair charges will be shared after in-store diagnosis at Cashify."
//                               : null,
//                           service: service,
//                         ),
//                       )
//                     else
//                       const Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text("No services available"),
//                       ),
//                     const SizedBox(height: 16),
//                     OtherRepairTile(),
//                     const SizedBox(height: 16),
//                     // Price Summary
//                     Obx(
//                       () => Container(
//                         height: repairController.selectedServices.isEmpty
//                             ? 130
//                             : null,
//                         child: Card(
//                           color: Colors.white,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                           elevation: 0.8,
//                           child: Padding(
//                             padding: EdgeInsets.all(20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Price Summary",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Divider(height: 24),
//                                 if (repairController.selectedServices.isEmpty)
//                                   Center(child: Text("No Service Selected"))
//                                 else
//                                   Column(
//                                     children: [
//                                       ...repairController.selectedServices
//                                           .map((service) {
//                                         return Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 4.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: Row(
//                                                   children: [
//                                                     Text(
//                                                       service.serviceName ?? "",
//                                                       style: TextStyle(
//                                                           fontSize: 14),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     "₹${(service.price ?? 0).toInt()}",
//                                                     style: TextStyle(
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         EdgeInsets.all(8.0),
//                                                     child: Text(
//                                                       ' ₹${(service.mrp)}',
//                                                       style: TextStyle(
//                                                           decoration:
//                                                               TextDecoration
//                                                                   .lineThrough,
//                                                           color: Colors.grey,
//                                                           fontSize: 13),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       }).toList(),
//                                       Divider(height: 24),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             "Total",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Text(
//                                             "₹${repairController.totalPrice.value}",
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     // Why Choose Us
//                     SizedBox(
//                       height: 240,
//                       child: Card(
//                         color: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 15, right: 15),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Why Choose Us?",
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.bold)),
//                               SizedBox(height: 16),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   FeatureColumn(
//                                       icon: Icons.currency_rupee,
//                                       label: "Pay after Service"),
//                                   FeatureColumn(
//                                       icon: Icons.calendar_month,
//                                       label: "Home Repair"),
//                                   FeatureColumn(
//                                       icon: Icons.lock_outline,
//                                       label: "Data Security"),
//                                 ],
//                               ),
//                               SizedBox(height: 18),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFE0F7FA),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                 child: const Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     StatsColumn(
//                                       title: "46 K+",
//                                       subtitle: "Device Repaired",
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                     ),
//                                     StatsColumn(
//                                       title: "4.3 K+",
//                                       subtitle: "Happy Customers",
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 24),
//                     // FAQs
//                     Padding(
//                       padding: EdgeInsets.only(right: 50),
//                       child: Align(
//                         child: Text(
//                           'Frequently Asked Questions',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     SizedBox(
//                       width: 350,
//                       child: ExpansionTile(
//                         title: Text(
//                           'What happens when I place an order?',
//                           style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(10),
//                             child: Text(
//                               'Once the order is placed, our support team contacts you to confirm your availability for the service & an executive is assigned for your order. The executive will reach your location at a preferred time & repair your device.',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 350,
//                       child: ExpansionTile(
//                         title: Text(
//                           'How do I pay for my order?',
//                           style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(10),
//                             child: Text(
//                               'Once the repair is completed by our technician, you can pay using the following methods: Cash, Paytm, UPI or Credit/Debit Card.',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 350,
//                       child: ExpansionTile(
//                         title: Text(
//                           'How will I get an invoice for the service?',
//                           style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(10),
//                             child: Text(
//                               'After the service is completed, the invoice will be shared with you via SMS or Email. You can also download it from your account section on our app.',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                   ],
//                 ),
//               ),
//       ),
//       bottomNavigationBar: Obx(
//         () => Padding(
//           padding: EdgeInsets.all(12.0),
//           child: BookNowButton(
//            onPressed:
//      () {
//         final controller = Get.find<RepairControllerTable>();
//         final total = controller.totalPrice.value;

//         // Pass `total` and other params as needed to next screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AddNewAddressScreen(
//               totalPrice: total,
//               selectedServices: controller.selectedServices,
//               // add other params you need here
//             ),
//           ),
//         );
//       }
//     : null,

//             totalPrice: repairController.totalPrice.value,
//           ),
//         ),
//       ),
//     );
//   }
// }
class SelectServicesScreen extends StatefulWidget {
  final String brandId;
  final String modelId;
  final String colorId;
  

  const SelectServicesScreen({
    super.key,
    required this.brandId,
    required this.modelId,
    required this.colorId, 
  });

  @override
  _SelectServicesScreenState createState() => _SelectServicesScreenState();
}

class _SelectServicesScreenState extends State<SelectServicesScreen> {
  final RepairControllerTable repairController =
      Get.put(RepairControllerTable());

  @override
  void initState() {
    super.initState();
    repairController.getTableRepairData(
        widget.brandId, widget.modelId, widget.colorId);
    //final List<Table1> selectedServices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Select Services"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        leading: const BackButton(),
      ),
      body: Obx(
        () => repairController.isRepairTableLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    if (repairController.tableRepairData?.table1?.isNotEmpty ??
                        false)
                      ...repairController.tableRepairData!.table1!.map(
                        (service) => ListTile(
                          title: Text(service.serviceName ?? ''),
                          trailing: Obx(() {
                            bool selected =
                                repairController.isServiceSelected(service);
                            return ElevatedButton(
                              onPressed: () {
                                if (selected) {
                                  repairController.removeService(service);
                                } else {
                                  repairController.addService(service);
                                }
                              },
                              child: Text(selected ? 'Remove' : 'Add +'),
                            );
                          }),
                        ),
                      ),
                    const SizedBox(height: 24),
                    Obx(
                      () => Card(
                        margin: const EdgeInsets.all(16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Price Summary",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const Divider(height: 20),
                              if (repairController.selectedServices.isEmpty)
                                const Center(child: Text("No Service Selected"))
                              else
                                ...repairController.selectedServices.map(
                                  (service) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(service.serviceName ?? ''),
                                        Text(
                                            "₹${(service.price ?? 0).toInt()}"),
                                      ],
                                    ),
                                  ),
                                ),
                              const Divider(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Total",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    "₹${repairController.totalPrice.value}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100), // Space before button
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(12.0),
          child: BookNowButton(
            onPressed: repairController.totalPrice.value > 0
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectRepairAddressScreen(
                          brandId: widget.brandId,
                          modelId: widget.modelId,
                          colorId: widget.colorId,
                          totalPrice: repairController.totalPrice.value,
                          selectedServices:
                              repairController.selectedServices.toList(),
                        ),
                      ),
                    );
                  }
                : null,
            totalPrice: repairController.totalPrice.value,
          ),
        ),
      ),
    );
  }
}
