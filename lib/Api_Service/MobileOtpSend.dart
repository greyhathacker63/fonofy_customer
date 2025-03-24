import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/model/MobileOtp.dart';
import 'package:http/http.dart' as http;

class OtpService {
  static const String apiUrl = 'https://api.fonofy.in/api/common/sendotp';

  Future<MobileOtp> sendOtp(String mobileNumber) async {
    print("Api Url");
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

  Future<bool> checkMobileNumber(String number)async{
    var url = Uri.parse("https://api.fonofy.in/api/common/check-mobile-number?mobileNumber=$number");
    var response = await http.get(url);
    if(response.statusCode == 400){
      return false;
    }else if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
}
