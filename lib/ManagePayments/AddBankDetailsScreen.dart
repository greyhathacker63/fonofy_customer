import 'package:flutter/material.dart';
import 'package:fonofy/controllers/ManagePaymentController/BankDetialsController.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class AddBankDetailsScreen extends StatefulWidget {
  const AddBankDetailsScreen({super.key});

  @override
  State<AddBankDetailsScreen> createState() => _AddBankDetailsScreenState();
}

class _AddBankDetailsScreenState extends State<AddBankDetailsScreen> {
  final _accountController = TextEditingController();
  final _confirmAccountController = TextEditingController();
  final _beneficiaryController = TextEditingController();
  final _ifscController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankController = Get.find<BankController>();
  var _isChecked = true;

  @override
  void initState() {
    super.initState();
    // Clear text fields when the screen is opened
    _accountController.clear();
    _confirmAccountController.clear();
    _beneficiaryController.clear();
    _ifscController.clear();
    _bankNameController.clear();
    _isChecked = true;
  }

  @override
  void dispose() {
    _accountController.dispose();
    _confirmAccountController.dispose();
    _beneficiaryController.dispose();
    _ifscController.dispose();
    _bankNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(),
            _buildHeader(),
            const SizedBox(height: 12),
            _buildTextField("Account no.*", _accountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(18),
                ]),
            const SizedBox(height: 12),
            _buildTextField("Confirm Account no.*", _confirmAccountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(18),
                ]),
            const SizedBox(height: 12),
            _buildTextField("Beneficiary Name*", _beneficiaryController,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                ]),
            const SizedBox(height: 12),
            _buildTextField("IFSC code*", _ifscController,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                  LengthLimitingTextInputFormatter(11),
                  UpperCaseTextFormatter(),
                ]),
            const SizedBox(height: 12),
            _buildTextField("Bank Name*", _bankNameController,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                ]),
            const SizedBox(height: 16),
            _buildDeclarationCheckbox(),
            const SizedBox(height: 8),
            _buildSecurityMessage(),
            const SizedBox(height: 24),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 50,
      height: 4,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Add Bank Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Obx(() => IconButton(
              icon: const Icon(Icons.close),
              onPressed: _bankController.isLoading.value ? null : () => Get.back(),
            )),
      ],
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        border: const UnderlineInputBorder(),
        hintStyle: const TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _buildDeclarationCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          activeColor: ColorConstants.appBlueColor3,
          value: _isChecked,
          onChanged: (val) => setState(() => _isChecked = val ?? false),
        ),
        const Expanded(
          child: Text(
            "I hereby declare that the details above are true to the best of my knowledge and belongs to me.",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: const [
          Icon(Icons.lock, size: 16, color: Colors.black54),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "Your account is encrypted and 100% safe with us.",
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _bankController.isLoading.value
                ? null
                : () {
                    _bankController.submitBankDetails(
                      accountNo: _accountController.text.trim(),
                      confirmAccountNo: _confirmAccountController.text.trim(),
                      beneficiary: _beneficiaryController.text.trim(),
                      ifsc: _ifscController.text.trim(),
                      bankName: _bankNameController.text.trim(),
                      isChecked: _isChecked,
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.appBlueColor3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _bankController.isLoading.value
                ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                : const Text("Add Account", style: TextStyle(color: Colors.white)),
          ),
        ));
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}