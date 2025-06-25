import 'package:get/get.dart';
import 'package:fonofy/model/RegisterModel/PhoneLoginModel.dart';
import 'package:fonofy/Api_Service/mobileOtpService/PhoneLoginService.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';

class PhoneLoginController extends GetxController {
  var isLoading = false.obs;
  var loginResponse = Rx<PhoneLoginModel?>(null);

  Future<bool> login(String mobileNo, String password) async {
    isLoading.value = true;
    final response = await PhoneLoginService.loginPhoneUser(
      mobileNo: mobileNo,
      password: password,
    );
    loginResponse.value = response;
    isLoading.value = false;

    if (response != null && response.token != null) {
      await TokenHelper.saveToken(response.token!);
      print("✅ Token saved: ${response.token}");
      return true;
    } else {
      print("⚠️ Login failed or token not received.");
      return false;
    }
  }
}
