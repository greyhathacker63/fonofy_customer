import 'package:flutter/material.dart';
import 'package:fonofy/ManagePayments/AddBankDetailsScreen.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';


class MyPaymentsScreen extends StatefulWidget {
  const MyPaymentsScreen({super.key});

  @override
  State<MyPaymentsScreen> createState() => _MyPaymentsScreenState();
}

class _MyPaymentsScreenState extends State<MyPaymentsScreen> {
  final List<Map<String, String>> vouchers = const [
    {"title": "Amazon Pay Gift Card", "subtitle": "Not linked yet."},
    {"title": "Flipkart Gift Card", "subtitle": "Not linked yet."},
    {"title": "Tata Cliq", "subtitle": "Not linked yet."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Payments", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          const Text("Saved Payments", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),

          // Bank Transfer
          _buildRowItem("Bank Transfer", "Add"),

          const SizedBox(height: 20),

          // UPI Section
          const Text("UPI", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          _buildUpiCard(),

          const SizedBox(height: 20),

          // Voucher Section
          const Text("Voucher", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),

          // Dynamic ListView.builder
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vouchers.length,
            itemBuilder: (context, index) {
              final voucher = vouchers[index];
              return _buildVoucherCard(voucher["title"]!, voucher["subtitle"]!);
            },
          ),
        ],
      ),
    );
  }

 Widget _buildRowItem(String label, String actionText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(fontSize: 15)),
      GestureDetector(
        onTap: () {
          if (actionText == "Add") {
            Get.bottomSheet(
              AddBankDetailsScreen(),
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            );
          }
        },
        child: Text(
          actionText,
          style: TextStyle(
            color: ColorConstants.appBlueColor3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}


  Widget _buildUpiCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: const Text("Upi"),
        subtitle: const Text("XXivam@ybl"),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.black54),
          onPressed: () {
            // Handle delete
          },
        ),
      ),
    );
  }

  Widget _buildVoucherCard(String title, String subtitle) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle),
        trailing: Text("Add", style: TextStyle(color: ColorConstants.appBlueColor3)),
      ),
    );
  }
}
