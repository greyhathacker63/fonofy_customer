import 'package:flutter/material.dart';
import 'package:fonofy/ManagePayments/AddBankDetailsScreen.dart';
import 'package:fonofy/ManagePayments/UpiIdBottomSheet.dart';
import 'package:fonofy/controllers/ManagePaymentController/BankDetialsController.dart';
import 'package:fonofy/controllers/ManagePaymentController/UpiController.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class MyPaymentsScreen extends StatefulWidget {
  const MyPaymentsScreen({super.key});

  @override
  State<MyPaymentsScreen> createState() => _MyPaymentsScreenState();
}

class _MyPaymentsScreenState extends State<MyPaymentsScreen> {
  final _vouchers = const [
    {"title": "Amazon Pay Gift Card", "subtitle": "Not linked yet."},
    {"title": "Flipkart Gift Card", "subtitle": "Not linked yet."},
    {"title": "Tata Cliq", "subtitle": "Not linked yet."},
  ];
  final _controller = Get.put(BankController());
  final _upiController = Get.put(UpiController());

  String? _upiId;

  @override
  void initState() {
    super.initState();
    _controller.fetchBankDetailsList();
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Bank Detail"),
        content:
            const Text("Are you sure you want to delete this bank detail?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog
              await _controller.deleteBankDetail(id);
              _controller.fetchBankDetailsList(); 
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

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
      body: RefreshIndicator(
        onRefresh: _controller.fetchBankDetailsList,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            _buildSectionTitle("Saved Payments"),
            const SizedBox(height: 16),
            _buildAddBankOption(),
            const SizedBox(height: 10),
            _buildBankDetailsList(),
            const SizedBox(height: 20),
            _buildSectionTitle("UPI"),
            const SizedBox(height: 8),
            _buildUpiCard(),
            const SizedBox(height: 20),
            _buildSectionTitle("Voucher"),
            const SizedBox(height: 8),
            ..._vouchers.map((voucher) => _buildCard(
                  title: voucher["title"]!,
                  subtitle: voucher["subtitle"]!,
                  trailingText: "Add",
                  onTap: () {},
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildAddBankOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Bank Transfer", style: TextStyle(fontSize: 15)),
        GestureDetector(
          onTap: () => Get.bottomSheet(
            const AddBankDetailsScreen(),
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ).then((_) => _controller.fetchBankDetailsList()),
          child: Text(
            "Add",
            style: TextStyle(
              color: ColorConstants.appBlueColor3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBankDetailsList() {
    return Obx(() {
      if (_controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (_controller.bankDetailsList.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "No bank accounts linked yet.",
            style: TextStyle(fontSize: 15, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _controller.bankDetailsList.length,
        itemBuilder: (context, index) {
          final account = _controller.bankDetailsList[index];
          return _buildCard(
            title: account.beneficiaryName,
            subtitle:
                "A/C: ${account.accountNumber}\nIFSC: ${account.ifscCode}",
            trailingIcon: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.black54),
              onPressed: () => _confirmDelete(account.id),
            ),
          );
        },
      );
    });
  }

  Widget _buildUpiCard() {
    return Obx(() {
      if (_upiController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final upis = _upiController.upiDetailsList;

      return Column(
        children: [
          ...upis.map((upi) {
            return _buildCard(
              title: "UPI",
              subtitle: upi.upiId.toString(),
              trailingIcon: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.black54),
                onPressed: () {
                  _upiController.deleteUpi(upi.id ?? 0);
                },
              ),
            );
          }).toList(),
          _buildCard(
            title: "UPI",
            subtitle: "Add",
            trailingIcon: const Icon(Icons.add, color: Colors.black54),
            onTap: () => Get.bottomSheet(
              AddUpiBottomSheet(
                onSubmit: (value) {
                  _upiController.submitUpi(value);
                  Get.back();
                },
              ),
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    Widget? trailingIcon,
    String? trailingText,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: trailingIcon != null ? 0 : 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle),
        trailing: trailingIcon ??
            (trailingText != null
                ? Text(trailingText,
                    style: TextStyle(color: ColorConstants.appBlueColor3))
                : null),
        onTap: onTap,
      ),
    );
  }
}
