import 'dart:convert';
import 'package:fonofy/models/MobileOtpModel/MobileOtpModel.dart';
import 'package:http/http.dart' as http;

class OtpService {
  static const String apiUrl = 'https://api.fonofy.in/api/common/sendotp';

  Future<MobileOtpModel> sendOtp(String mobileNumber) async {
    final response = await http.get(Uri.parse('$apiUrl?mobileNumber=$mobileNumber'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return MobileOtpModel.fromJson(data);
    } else {
      throw Exception('Failed to send OTP');
    }
  }

  Future<bool> checkMobileNumber(String number) async {
    var url = Uri.parse("https://api.fonofy.in/api/common/check-mobile-number?mobileNumber=$number");
    var response = await http.get(url);

    if (response.statusCode == 400) {
      return false;
    } else if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
