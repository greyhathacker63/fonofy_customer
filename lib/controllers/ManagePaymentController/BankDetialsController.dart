import 'package:fonofy/Api_Service/ManagePaymentService/BankDetailsService.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/ManagePaymentsModel/BandDetailsModel.dart';
import 'package:get/get.dart';
import 'dart:developer';


class BankController extends GetxController {
  final isLoading = false.obs;
  final bankDetailsList = <BankDetails>[].obs;

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
      log("fetchBankDetailsList succeeded with ${result.data.length} items");
      bankDetailsList.value = result.data;
      if (result.data.isEmpty) {
        log("No bank details found");
        _showSnackbar("Info", "No bank details found.");
      }
    } else {
      log("fetchBankDetailsList failed: ${result.errorMessage}");
      bankDetailsList.value = [];
      _showSnackbar("Failed", result.errorMessage ?? "Could not fetch bank details.");
    }
  }
}