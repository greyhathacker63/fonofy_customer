import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:get/get.dart';
import '../../controllers/RepairController/RepairServicesTableController.dart';
import '../../widgets/RepairWidets/BookNowButton.dart';
import '../../widgets/RepairWidets/DevicePhoneInfoCard.dart';
import '../../widgets/RepairWidets/FeatureColumn.dart';
import '../../widgets/RepairWidets/OtherRepairTile.dart';
import '../../widgets/RepairWidets/ServicePhoneItem.dart';
import '../../widgets/RepairWidets/StatsColumn.dart';

class SelectServicesScreen extends StatefulWidget {
  final String brandId;
  final String productId;
  final String colorId;

  const SelectServicesScreen({
    super.key,
    required this.brandId,
    required this.productId,
    required this.colorId,
  });

  @override
  _SelectServicesScreenState createState() => _SelectServicesScreenState();
}

class _SelectServicesScreenState extends State<SelectServicesScreen> {

  final RepairControllerTable repairController = Get.put(RepairControllerTable());

  @override
  void initState() {
    super.initState();
    repairController.getTableRepairData(widget.brandId, widget.productId, widget.colorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
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
              // Display DevicePhoneInfoCard with Table data
              if (repairController.tableRepairData?.table?.isNotEmpty ?? false)
                DevicePhoneInfoCard(repairTable: repairController.tableRepairData?.table)
              else
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("No device data available"),
                ),
              // ServicePhoneItem for each Table1 entry
              if (repairController.tableRepairData?.table1?.isNotEmpty ?? false)
                ...repairController.tableRepairData!.table1!.map(
                      (service) => ServicePhoneItem(
                    image: "$imageAllBaseUrl${service.serviceImage}",
                    title: service.serviceName ?? "",
                    discount: (service.disPercentage ?? 0).toInt(),
                    price: (service.price ?? 0).toInt(),
                    mrp: (service.mrp ?? 0).toInt(),
                    note: service.id == 0
                        ? "This ₹99 is only for inspection. Final repair charges will be shared after in-store diagnosis at Cashify."
                        : null,
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("No services available"),
                ),
              const SizedBox(height: 16),
              const OtherRepairTile(),
              const SizedBox(height: 16),
              Container(
                height: 130,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0.8,
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price Summary", style: TextStyle(fontWeight: FontWeight.bold)),
                        Divider(height: 24),
                        Center(child: Text("No Service Selected")),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 240,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Why Choose Us?", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            FeatureColumn(icon: Icons.currency_rupee, label: "Pay after Service"),
                            FeatureColumn(icon: Icons.calendar_month, label: "Home Repair"),
                            FeatureColumn(icon: Icons.lock_outline, label: "Data Security"),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFE0F7FA),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:   [
                              StatsColumn(
                                title: "46 K+",
                                subtitle: "Device Repaired",
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              StatsColumn(
                                title: "4.3 K+",
                                subtitle: "Happy Customers",
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                SizedBox(height: 24),
               Padding(
                padding: EdgeInsets.only(right: 50),
                child: Align(

                  child: Text(
                    'Frequently Asked Questions',
                    style: TextStyle(fontSize : 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
                SizedBox(height: 8),
                SizedBox(
                width: 350,
                child: ExpansionTile(
                  title: Text('What happens when I place an order?',
                    style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Once the order is placed, our support team contacts you to confirm your availability for the service & an executive is assigned for your order. The executive will reach your location at a preferred time & repair your device.',
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
                SizedBox(
                width: 350,
                child: ExpansionTile(
                  title: Text(
                    'How do I pay for my order?',
                    style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Once the repair is completed by our technician, you can pay using the following methods: Cash, Paytm, UPI or Credit/Debit Card.',
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
                SizedBox(
                  width: 350,
                child: ExpansionTile(
                  title: Text(
                    'How will I get an invoice for the service?',
                    style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'After the service is completed, the invoice will be shared with you via SMS or Email. You can also download it from your account section on our app.',
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
                SizedBox(height: 15),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:   EdgeInsets.all(12.0),
        child: BookNowButton(onPressed: () {}),
      ),
    );
  }
}