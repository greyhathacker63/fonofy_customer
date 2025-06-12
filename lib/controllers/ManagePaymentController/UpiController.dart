import 'dart:developer';
import 'package:fonofy/ManagePayments/UpiService.dart';
import 'package:fonofy/model/ManagePaymentsModel/BankDetailsModel.dart';
import 'package:get/get.dart';


class UpiController extends GetxController {
  final isLoading = false.obs;
  final upiId = ''.obs; // For binding TextField
  final upiDetailsList = <UpiDetails>[].obs;

  void _showSnackbar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.TOP);
  }

  @override
  void onInit() {
    super.onInit();
    fetchUpiDetails(); // Load data on init
  }

  Future<void> submitUpi(String upi) async {
    if (upi.trim().isEmpty) {
      _showSnackbar("Validation Error", "Please enter a valid UPI ID");
      return;
    }

    isLoading.value = true;
    final success = await UpiService.addUpi(upi);
    isLoading.value = false;

    if (success) {
      upiId.value = ''; // Clear input
      _showSnackbar("Success", "UPI ID added successfully");
      await fetchUpiDetails();
    } else {
      _showSnackbar("Failed", "Failed to add UPI ID");
    }
  }

  Future<void> deleteUpi(int id) async {
    isLoading.value = true;

    final success = await UpiService.deleteUpi(id);
    isLoading.value = false;

    if (success) {
      _showSnackbar("Success", "UPI ID deleted successfully");
      await fetchUpiDetails();
    } else {
      _showSnackbar("Error", "Failed to delete UPI ID");
    }
  }

  Future<void> fetchUpiDetails() async {
    isLoading.value = true;
    final result = await UpiService.getUpiList();
    isLoading.value = false;

    if (result != null) {
      upiDetailsList.value = result;
    } else {
      _showSnackbar("Error", "Failed to load UPI list");
    }
  }
}
