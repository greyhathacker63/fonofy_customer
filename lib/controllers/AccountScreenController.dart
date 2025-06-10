import 'package:flutter/material.dart';
import 'package:fonofy/ViewScreen/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../AccountApiService/DeleteAccountService.dart';
import '../../TokenHelper/TokenHelper.dart';

class AccountController extends GetxController {
  var isLoading = true.obs;
  var servicesExpanded = false.obs;
  var settingsExpanded = false.obs;
  var aboutExpanded = false.obs;

  var userCode = "".obs;
  var token = "".obs;

  @override
  void onInit() {
    super.onInit();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    String? fetchedToken = await TokenHelper.getToken();
    String? fetchedUserCode = await TokenHelper.getUserCode();

    if (fetchedToken == null) {
      Get.off(LoginScreen());; // Or use Get.off(LoginScreen());
    } else {
      userCode.value = fetchedUserCode ?? "";
      token.value = fetchedToken;
      isLoading.value = false;
    }
  }

  Future<void> navigateToManageAddress(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString("UserCode");

    if (customerId != null && customerId.isNotEmpty && token.isNotEmpty) {
      Navigator.pushNamed(context, '/manage-address', arguments: customerId);
    } else {
      Get.snackbar(
        "Error",
        "⚠️ User code is missing!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> logout() async {
    await TokenHelper.removeToken();
    await TokenHelper.removeUserCode();
    await TokenHelper.deleteUserData();

    String? tok = await TokenHelper.getToken();
    if (tok == null) {
      Get.offAllNamed('/login'); // Or use Get.off(LoginScreen());
    }
  }

  Future<void> deleteAccount() async {
    try {
      final tokenVal = await TokenHelper.getToken();
      final userCodeVal = await TokenHelper.getUserCode();

      if (tokenVal == null || userCodeVal == null) {
        Get.snackbar("Error", "Missing user credentials");
        return;
      }

      final success = await DeleteAccountService.deleteUserProfile(tokenVal, userCodeVal);
      if (success) {
        await TokenHelper.deleteUserData();
        Get.snackbar("Success", "Account deleted successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed('/main'); // Or use Get.offAll(MainScreen());
      } else {
        Get.snackbar("Failed", "Account deletion failed",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("❌ Delete Error: $e");
      Get.snackbar("Error", "An unexpected error occurred");
    }
  }

  void toggleServices() => servicesExpanded.toggle();
  void toggleSettings() => settingsExpanded.toggle();
  void toggleAbout() => aboutExpanded.toggle();
}
