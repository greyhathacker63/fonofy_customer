import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/model/MobileOtp.dart';
import 'package:http/http.dart' as http;

class OtpService {
<<<<<<< HEAD
  static const String apiUrl = 'http://api.fonofy.in/api/common/sendotp';
=======
  static const String apiUrl = 'https://api.fonofy.in/api/common/sendotp';
>>>>>>> vinay/users

  Future<MobileOtp> sendOtp(String mobileNumber) async {
    print("Api Url ");
    print(apiUrl);
    final response = await http.get(
      Uri.parse('$apiUrl?mobileNumber=$mobileNumber'),
    );
    if (response.statusCode == 200) {
      print("Inside Data " + jsonDecode(response.body));
      return MobileOtp.fromJson(jsonDecode(response.body));
    } else {
      print("OutSide Else ");
      throw Exception('Failed to send OTP');
    }
  }
}
