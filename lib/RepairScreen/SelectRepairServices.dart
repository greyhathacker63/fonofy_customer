import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/Manage%20Address/AddNewAddressScreen.dart';
import 'package:fonofy/model/RepairModel/BookingRepairModel.dart';
import 'package:fonofy/model/RepairModel/RepairServicesTableModel.dart';
import '../controllers/RepairController/RepairServicesTableController.dart';
import '../model/table_banner_model/SelectProduct/SelectAddressScreen.dart';
import '../widgets/RepairWidets/BookNowButton.dart';
import '../widgets/RepairWidets/DevicePhoneInfoCard.dart';
import '../widgets/RepairWidets/FeatureColumn.dart';
import '../widgets/RepairWidets/OtherRepairTile.dart';
import '../widgets/RepairWidets/ServicePhoneItem.dart';
import '../widgets/RepairWidets/StatsColumn.dart';

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
            ? const Center(
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.blue),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Device Info
                    if (repairController.tableRepairData?.table?.isNotEmpty ??
                        false)
                      DevicePhoneInfoCard(
                        repairTable: repairController.tableRepairData?.table,
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("No device data available"),
                      ),

                    const SizedBox(height: 16),

// Services List
                    if (repairController.tableRepairData?.table1?.isNotEmpty ??
                        false)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: repairController.tableRepairData!.table1!
                              .map(
                                (service) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ServicePhoneItem(
                                    image:
                                        "$imageAllBaseUrl${service.serviceImage}",
                                    title: service.serviceName ?? "",
                                    discount:
                                        (service.disPercentage ?? 0).toInt(),
                                    price: (service.price ?? 0).toInt(),
                                    mrp: (service.mrp ?? 0).toInt(),
                                    note: service.id == 0
                                        ? "This ₹99 is only for inspection. Final repair charges will be shared after in-store diagnosis at Cashify."
                                        : null,
                                    service: service,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("No services available"),
                      ),

                    const SizedBox(height: 16),
                    OtherRepairTile(),
                    const SizedBox(height: 16),

                    // Price Summary Card
                    Obx(
                      () => Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Price Summary",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const Divider(height: 24),
                              if (repairController.selectedServices.isEmpty)
                                const Center(child: Text("No Service Selected"))
                              else
                                Column(
                                  children: [
                                    ...repairController.selectedServices.map(
                                      (service) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(service.serviceName ?? "",
                                                style: const TextStyle(
                                                    fontSize: 14)),
                                            Row(
                                              children: [
                                                Text(
                                                  "₹${(service.price ?? 0).toInt()}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  "₹${(service.mrp ?? 0).toInt()}",
                                                  style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                          ramId: repairController.ramId,
                          romId: repairController.romId,
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

//       body: Obx(
//         () => repairController.isRepairTableLoading.value
//             ? const Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     if (repairController.tableRepairData?.table1?.isNotEmpty ??
//                         false)
//                       ...repairController.tableRepairData!.table1!.map(
//                         (service) => ListTile(
//                           title: Text(service.serviceName ?? ''),
//                           trailing: Obx(() {
//                             bool selected =
//                                 repairController.isServiceSelected(service);
//                             return ElevatedButton(
//                               onPressed: () {
//                                 if (selected) {
//                                   repairController.removeService(service);
//                                 } else {
//                                   repairController.addService(service);
//                                 }
//                               },
//                               child: Text(selected ? 'Remove' : 'Add +'),
//                             );
//                           }),
//                         ),
//                       ),
//                     const SizedBox(height: 24),
//                     Obx(
//                       () => Card(
//                         margin: const EdgeInsets.all(16),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text("Price Summary",
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.bold)),
//                               const Divider(height: 20),
//                               if (repairController.selectedServices.isEmpty)
//                                 const Center(child: Text("No Service Selected"))
//                               else
//                                 ...repairController.selectedServices.map(
//                                   (service) => Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 4.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(service.serviceName ?? ''),
//                                         Text(
//                                             "₹${(service.price ?? 0).toInt()}"),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               const Divider(height: 24),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text("Total",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   Text(
//                                     "₹${repairController.totalPrice.value}",
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 100), // Space before button
//                   ],
//                 ),
//               ),
//       ),
//       bottomNavigationBar: Obx(
//         () => Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: BookNowButton(
//             onPressed: repairController.totalPrice.value > 0
//                 ? () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SelectRepairAddressScreen(
//                           brandId: widget.brandId,
//                           modelId: widget.modelId,
//                           colorId: widget.colorId,
//                           totalPrice: repairController.totalPrice.value,
//                           selectedServices:
//                               repairController.selectedServices.toList(),
//                           ramId: repairController.ramId,  
//                           romId: repairController.romId, 
//                         ),
//                       ),
//                     );
//                   }
//                 : null,
//             totalPrice: repairController.totalPrice.value,
//           ),
//         ),
//       ),
//     );
//   }