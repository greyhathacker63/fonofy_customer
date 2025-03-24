import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {

  Future<bool> checkMobileNumber(String mobileNumber) async {
    final String apiUrl = "https://api.fonofy.in/api/common/check-mobile-number?mobileNumber=";

    final response = await http.get(Uri.parse(apiUrl + mobileNumber));
    if (response.statusCode == 200) {
      return true;
    } else if(response.statusCode == 400){
      return false;
    }else{
      return false;
    }
  }

  Future<Map<String, dynamic>> getOtp(String mobileNumber) async {
    final url = Uri.parse("https://api.fonofy.in/api/common/sendotp?mobileNumber=$mobileNumber");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data =  jsonDecode(response.body);
        return {
          "otp":data['otp'],
          "status":true
        };
      } else {
        return {
          "status":false
        };
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  bool verifyOTP({required String userOTP, required String otp}){
    return userOTP == otp;
  }
}
