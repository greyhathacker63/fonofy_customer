import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/RepairColorModelService/RepairOrderListService.dart';
import 'package:fonofy/controllers/RepairController/RepairOrderListController.dart';
import '../controllers/RepairController/RepairCancelReasonListController.dart';
import '../utils/Colors.dart';
import 'package:get/get.dart';
import '../../controllers/RepairController/CancelRepairOrderController.dart';

class CancelRepairOrderScreen extends StatefulWidget {
  final String orderId;
  final String customerId;

  const CancelRepairOrderScreen({
    Key? key,
    required this.orderId,
    required this.customerId,
  }) : super(key: key);

  @override
  _CancelRepairOrderScreenState createState() => _CancelRepairOrderScreenState();
}

class _CancelRepairOrderScreenState extends State<CancelRepairOrderScreen> {

  final ControllerRepairCancelReasonList controllerRepairCancelReason = Get.put(ControllerRepairCancelReasonList());

  final CancelRepairOrderController cancelController = Get.put(CancelRepairOrderController());

  final RepairOrderListController repairOrderListController = Get.find<RepairOrderListController>();

  String? selectedReasonId;

  TextEditingController otherReasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerRepairCancelReason.getRepairCancelReasonData();
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: ColorConstants.appBlueColor3,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: Text('Cancel',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    Text('Do you really want to cancel?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: ColorConstants.appBlueColor3),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text('NO',
                              style: TextStyle(
                                color: ColorConstants.appBlueColor3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              final reasonText = controllerRepairCancelReason.repairCancelReasonData?.table
                                  .firstWhereOrNull((item) => item.id.toString() == selectedReasonId)
                                  ?.reason ??
                                  '';
                              final enteredRemark = otherReasonController.text.trim();
                              print("Cancel Parameters: OrderId: ${widget.orderId}, CustomerId: ${widget.customerId}, Reason: $reasonText, ReasonId: $selectedReasonId, Remark: $enteredRemark");

                              await cancelController.cancelRepairOrder(
                                orderId: widget.orderId,
                                customerId: widget.customerId,
                                reasone: reasonText,
                                reasonId: selectedReasonId ?? '',
                                reasonRemark: enteredRemark,
                              );
                             },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.appBlueColor3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text('YES',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )

                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Reason for cancellation",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, size: 24),
                    ),
                  ],
                ),
                SizedBox(height: 18),

                // Subtitle
                Text("Please tell us the reason",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),

                Obx(() {
                  if (controllerRepairCancelReason.isRepairCancelReasonLoading.value) {
                    return Center(
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue));
                  }
                  final repairCancelReasonDetails = controllerRepairCancelReason.repairCancelReasonData?.table ?? [];
                  return Column(
                    children: repairCancelReasonDetails.map((item) {
                      return RadioListTile<String>(
                        value: item.id.toString(),
                        groupValue: selectedReasonId,
                        dense: true,
                        visualDensity: VisualDensity(vertical: -4),
                        contentPadding: EdgeInsets.zero,
                        title: Text(item.reason ?? '', style: TextStyle(fontSize: 14)),
                        onChanged: (value) {
                          setState(() {
                            selectedReasonId = value;
                          });
                        },
                        activeColor: ColorConstants.appBlueColor3,
                      );
                    }).toList(),
                  );
                }),

                 Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 20),
                  child: TextField(
                    controller: otherReasonController,
                    decoration: InputDecoration(
                      hintText: "Tell us what we missed!",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),

                // Confirm Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedReasonId == null &&
                          otherReasonController.text.trim().isEmpty) {
                        Get.snackbar(
                          "Reason Required",
                          "Please select or enter a cancellation reason.",
                          backgroundColor: ColorConstants.appBlueColor3,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      _showCancelDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.appBlueColor3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "CONFIRM",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

