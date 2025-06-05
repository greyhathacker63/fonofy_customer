import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../TokenHelper/TokenHelper.dart';
import '../../models/RegisterModel/RegisterModel.dart';

class RegisterService {

  static const String registerApiUrl = "https://api.fonofy.in/api/forb2c/register";
  Future<RegisterModel> registerApi(String registerData) async {
    try {
      final response = await http.post(
        Uri.parse(registerApiUrl),
        headers: {'Content-Type': 'application/json',},
        body: registerData,
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        // Save the token using TokenHelper
        await TokenHelper.saveToken(jsonData["token"]);

        return RegisterModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  Future<Map<String, dynamic>> getOtpphone(String mobileNumber) async {
    final url = Uri.parse("https://api.fonofy.in/api/common/sendotp?mobileNumber=$mobileNumber");
    try {

      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return {
          "otp": data['otp'],
          "status": true
        };
      } else {
        return {"status": false};
      }
    } catch (e) {
      return {"status": false};
    }
  }
}

