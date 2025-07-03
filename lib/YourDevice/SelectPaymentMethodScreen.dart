import 'package:flutter/material.dart';
import 'package:fonofy/controllers/SellControllers/SellBookingController.dart';
import 'package:fonofy/model/SellDevice/SellBookingModel.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:fonofy/widgets/thankYouWidget.dart';
import 'package:get/get.dart';
import 'package:fonofy/controllers/ManagePaymentController/BankDetialsController.dart';
import 'package:fonofy/controllers/ManagePaymentController/UpiController.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  final String shippingId;
  final String shippingName;
  final String shippingMobileNo;
  final String shippingEmailId;
  final String shippingAddress;
  final String shippingLandmark;
  final String shippingCity;
  final String shippingState;
  final String shippingPincode;
  final String workType;
  final String finalPrice;
  final String baseprice;
  final String pid;
  final String bid;
  final String raid;
  final String roid;
  final String selectedVariant;
  final String modelNo;
  final String ram;
  final String rom;
  final String modelName;
  final List finalhPageAns;
  final DateTime selectedDate;
  final String selectedTimeSlot;

  const SelectPaymentMethodScreen({
    super.key,
    required this.shippingId,
    required this.shippingName,
    required this.shippingMobileNo,
    required this.shippingEmailId,
    required this.shippingAddress,
    required this.shippingLandmark,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingPincode,
    required this.workType,
    required this.finalPrice,
    required this.baseprice,
    required this.pid,
    required this.bid,
    required this.raid,
    required this.roid,
    required this.selectedVariant,
    required this.modelNo,
    required this.ram,
    required this.rom,
    required this.modelName,
    required this.finalhPageAns,
    required this.selectedDate,
    required this.selectedTimeSlot,
  });

  @override
  State<SelectPaymentMethodScreen> createState() =>
      _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  final _bankController = Get.put(BankController());
  final _upiController = Get.put(UpiController());
  final _sellBookingController = Get.put(SellBookingController());

  String? _selectedMethod;
  String? accountId;
  String? accountType;

  @override
  void initState() {
    super.initState();
    _bankController.fetchBankDetailsList();
    _upiController.fetchUpiDetails();
  }

  void _handleSelection(String? methodValue) {
    if (methodValue == null) return;
    setState(() {
      _selectedMethod = methodValue;
      final parts = methodValue.split('_');
      if (parts.length == 2) {
        accountType = parts[0].toUpperCase();
        accountId = parts[1];
      }
    });
  }

  Future<void> _submitSellBooking() async {
    if (accountId == null || accountType == null) {
      Get.snackbar("Error", "Please select a payment method.");
      return;
    }

    final model = Sellbookingmodel(
  modelId: int.tryParse(widget.modelNo),
  romId: int.tryParse(widget.roid),
  ramId: int.tryParse(widget.raid),
  colorId: 5,
  orderId: "",
  shippingId: widget.shippingId,
  shippingName: widget.shippingName,
  shippingMobileNo: widget.shippingMobileNo,
  shippingEmailId: widget.shippingEmailId.trim(),
  shippingAddress: widget.shippingAddress,
  shippingLandmark: widget.shippingState,
  shippingCity: 123,
  shippingState: 23,
  shippingPincode: widget.shippingPincode,
  workType: widget.workType,
  pickupslotDate:
      "${widget.selectedDate.day.toString().padLeft(2, '0')}-${widget.selectedDate.month.toString().padLeft(2, '0')}-${widget.selectedDate.year.toString().substring(2)}",
  pickupslotTime: widget.selectedTimeSlot,
  accountId: int.tryParse(accountId!),
  accountType: accountType!,
  remark: "good",
  pickupCharge: 0,
  processingFee: 0,
  totalAmount: double.tryParse(widget.finalPrice),
  totalPrice: double.tryParse(widget.baseprice),
  totalDiscount: 0,
  totalMRP: double.tryParse(widget.baseprice),
  sellquestionlists: [
    SellQuestionList(
      questionRefno: "8fb62eae-50a2-4a1b-9314-b39868691bf8",
      question: "Is your phone's screen original?",
      questionId: 5,
      answerId: 3,
      answer: "NO",
      weightage: 6.0,
    ),
  ],
);

// ✅ ADD DEBUG PRINTS HERE
print('--- DEBUG Sellbookingmodel Data ---');
print('ModelId: ${int.tryParse(widget.modelNo)}');
print('ROMId: ${int.tryParse(widget.roid)}');
print('RAMId: ${int.tryParse(widget.raid)}');
print('ColorId: 5');
print('OrderId: ""');
print('ShippingId: ${widget.shippingId}');
print('ShippingName: ${widget.shippingName}');
print('ShippingMobileNo: ${widget.shippingMobileNo}');
print('ShippingEmailId: "${widget.shippingEmailId}"');
print('ShippingAddress: ${widget.shippingAddress}');
print('ShippingLandmark: ${widget.shippingState}');
print('ShippingCity: ${int.tryParse(widget.shippingCity)}');
print('ShippingState: ${int.tryParse(widget.shippingState)}');
print('ShippingPincode: ${widget.shippingPincode}');
print('WorkType: ${widget.workType}');
print('PickupslotDate: ${model.pickupslotDate}');
print('PickupslotTime: ${widget.selectedTimeSlot}');
print('AccountId: $accountId');
print('AccountType: $accountType');
print('TotalAmount: ${widget.finalPrice}');
print('TotalPrice: ${widget.baseprice}');
print('TotalMRP: ${widget.baseprice}');
//print('Sell Question List: ${jsonEncode(model.sellquestionlists.map((e) => e.toJson()).toList())}');

// Optional: Print final JSON payload
//print('📦 Final JSON Payload: ${jsonEncode(model.toJson())}');


    final result = await _sellBookingController.submitSellBooking(model);
    if (result) {
      showThankYouDialog(context, widget.shippingName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Select Payment Method")),
      body: Obx(() {
        final banks = _bankController.bankDetailsList;
        final upis = _upiController.upiDetailsList;

        return ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text("Bank Transfer",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            ...banks.map((bank) => RadioListTile<String>(
                  value: "bank_${bank.id}",
                  groupValue: _selectedMethod,
                  title: Text(bank.beneficiaryName),
                  subtitle: Text(
                      "A/C: ${bank.accountNumber} • IFSC: ${bank.ifscCode}"),
                  onChanged: _handleSelection,
                )),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text("UPI",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            ...upis.map((upi) => RadioListTile<String>(
                  value: "upi_${upi.id}",
                  groupValue: _selectedMethod,
                  title: const Text("UPI"),
                  subtitle: Text(upi.upiId ?? ""),
                  onChanged: _handleSelection,
                )),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _sellBookingController.isLoading.value
                ? null
                : () => _submitSellBooking(),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _selectedMethod != null ? ColorConstants.appBlueColor3 : Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _sellBookingController.isLoading.value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Sell Now",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        );
      }),
    );
  }
}
