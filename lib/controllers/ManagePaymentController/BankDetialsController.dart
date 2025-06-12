import 'package:fonofy/Api_Service/ManagePaymentService/BankDetailsService.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/ManagePaymentsModel/BankDetailsModel.dart';
import 'package:get/get.dart';
import 'dart:developer';

class BankController extends GetxController {
  final isLoading = false.obs;
  final bankDetailsList = <BankDetails>[].obs;
  final upiDetailsList = <UpiDetails>[].obs;

  void _showSnackbar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.TOP);
  }

  String? _validateBankDetails({
    required String accountNo,
    required String confirmAccountNo,
    required String beneficiary,
    required String ifsc,
    required String bankName,
    required bool isChecked,
  }) {
    if (accountNo.trim().isEmpty) return "Please enter Account Number";
    if (confirmAccountNo.trim().isEmpty) return "Please confirm Account Number";
    if (accountNo.trim() != confirmAccountNo.trim()) return "Account numbers do not match";
    if (beneficiary.trim().isEmpty) return "Please enter Beneficiary Name";
    if (ifsc.trim().isEmpty) return "Please enter IFSC Code";
    if (bankName.trim().isEmpty) return "Please enter Bank Name";
    if (!isChecked) return "Please accept the declaration";
    return null;
  }

  Future<void> submitBankDetails({
    required String accountNo,
    required String confirmAccountNo,
    required String beneficiary,
    required String ifsc,
    required String bankName,
    required bool isChecked,
  }) async {
    log("submitBankDetails called with accountNo: $accountNo, beneficiary: $beneficiary");

    final validationError = _validateBankDetails(
      accountNo: accountNo,
      confirmAccountNo: confirmAccountNo,
      beneficiary: beneficiary,
      ifsc: ifsc,
      bankName: bankName,
      isChecked: isChecked,
    );
    if (validationError != null) {
      log("Validation failed: $validationError");
      _showSnackbar("Validation Error", validationError);
      return;
    }

    final customerId = await TokenHelper.getUserCode();
    if (customerId == null) {
      log("Customer ID not found");
      _showSnackbar("Error", "Customer ID not found.");
      return;
    }

    isLoading.value = true;
    final model = BankDetailsRequest(
      accountNumber: accountNo,
      confirmAccountNumber: confirmAccountNo,
      beneficiaryName: beneficiary,
      ifscCode: ifsc,
      bankName: bankName,
      customerId: customerId,
      isDeclarationAccepted: isChecked,
    );

    log("Submitting bank details for customerId: $customerId");
    final success = await BankService.addBankDetails(model);
    isLoading.value = false;

    if (success) {
      log("Bank details added successfully");
      Get.back();
      _showSnackbar("Success", "Bank details added successfully");
      await fetchBankDetailsList();
    } else {
      log("Failed to add bank details");
      _showSnackbar("Failed", "Could not add bank details. Please try again.");
    }
  }

  Future<void> fetchBankDetailsList() async {
    log("fetchBankDetailsList called");
    isLoading.value = true;
    final result = await BankService.getBankDetailsList();
    isLoading.value = false;

    if (result.success) {
      final data = result.data;
      log("Fetched ${data.bankDetails.length} bank details and ${data.upiDetails.length} UPI details");

      bankDetailsList.value = data.bankDetails;
      upiDetailsList.value = data.upiDetails;

      if (data.bankDetails.isEmpty && data.upiDetails.isEmpty) {
        _showSnackbar("Info", "No payment details found.");
      }
    } else {
      log("Failed to fetch bank/upi details: ${result.errorMessage}");
      bankDetailsList.clear();
      upiDetailsList.clear();
      _showSnackbar("Failed", result.errorMessage ?? "Could not fetch bank details.");
    }
  }

  /// 🔥 NEW: Delete bank detail by ID
  Future<void> deleteBankDetail(int id) async {
    log("deleteBankDetail called with id: $id");
    isLoading.value = true;
    final success = await BankService.deleteBankDetails(id);
    isLoading.value = false;

    if (success) {
      log("Bank detail deleted successfully");
      _showSnackbar("Success", "Bank detail deleted successfully");
      await fetchBankDetailsList();
    } else {
      log("Failed to delete bank detail");
      _showSnackbar("Error", "Could not delete bank detail. Please try again.");
    }
  }
}
