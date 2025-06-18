import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/controllers/ManagePaymentController/BankDetialsController.dart';
import 'package:fonofy/controllers/ManagePaymentController/UpiController.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  State<SelectPaymentMethodScreen> createState() => _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  final _bankController = Get.put(BankController());
  final _upiController = Get.put(UpiController());

  String? _selectedMethod; 

  @override
  void initState() {
    super.initState();
    _bankController.fetchBankDetailsList();
    _upiController. fetchUpiDetails(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Payment Method"),
      ),
      body: Obx(() {
        final banks = _bankController.bankDetailsList;
        final upis = _upiController.upiDetailsList;

        return ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text("Bank Transfer", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            ...banks.map((bank) => RadioListTile<String>(
              value: "bank_${bank.id}",
              groupValue: _selectedMethod,
              title: Text(bank.beneficiaryName),
              subtitle: Text("A/C: ${bank.accountNumber} • IFSC: ${bank.ifscCode}"),
              onChanged: (val) => setState(() => _selectedMethod = val),
            )),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text("UPI", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            ...upis.map((upi) => RadioListTile<String>(
              value: "upi_${upi.id}",
              groupValue: _selectedMethod,
              title: const Text("UPI"),
              subtitle: Text(upi.upiId ?? ""),
              onChanged: (val) => setState(() => _selectedMethod = val),
            )),
          ],
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _selectedMethod != null ? () {
            // handle selection confirmation here
            Get.back(result: _selectedMethod); // or pass the object if needed
          } : null,
          child: const Text("Confirm Selection"),
        ),
      ),
    );
  }
}
