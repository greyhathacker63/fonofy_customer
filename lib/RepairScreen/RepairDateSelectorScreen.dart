import 'package:flutter/material.dart';
import 'package:fonofy/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/RepairController/RepairBookingController.dart';
import '../controllers/RepairController/RepairServicesTableController.dart';
import '../model/table_banner_model/SelectProduct/ThankYouRepairScreen.dart';
import '../utils/Colors.dart';

class RepairDateSelectorScreen extends StatefulWidget {
  const RepairDateSelectorScreen({super.key});

  @override
  _RepairDateSelectorScreenState createState() => _RepairDateSelectorScreenState();
}

class _RepairDateSelectorScreenState extends State<RepairDateSelectorScreen> {


  int selectedIndex = 0;

  final RepairControllerTable repairController = Get.find<RepairControllerTable>();

    final ProductController productController = Get.put(ProductController());

  final RepairBookingController repairBookingController = Get.put(RepairBookingController());

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
              physics: NeverScrollableScrollPhysics(),
              itemCount: dateList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 0),
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
                              style: TextStyle(
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
                        SizedBox(height: 4),
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration:   BoxDecoration(
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
                  Text(repairController.totalPrice.value > 0
                        ? "₹${repairController.totalPrice.value}"
                        : "₹0",
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
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: ColorConstants.appBlueColor3,
              ),
              onPressed: () {
                Get.off(()=>ThankYouRepairScreen());
                // final selectedDate = dateList[selectedIndex];
                // Navigator.pop(context, selectedDate); // Return selected date to previous screen
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
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


