import 'dart:convert';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:http/http.dart' as http;
import 'package:fonofy/model/RegisterModel/PhoneLoginModel.dart';

import '../BaseUrl/AllBaseUrl.dart';



class PhoneLoginService {
  // static const String _baseUrl = 'https://api.fonofy.in/api/forb2c/login';

  static Future<PhoneLoginModel?> loginPhoneUser({
    required String mobileNo,
    required String password,
  }) async {
    try {
      final response = await http.post(Uri.parse(phoneLoginUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "MobileNo": mobileNo,
          "Password": password,
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final model = PhoneLoginModel.fromJson(json);


        if (model.token != null && model.token!.isNotEmpty) {
          await TokenHelper.saveToken(model.token!);
          print("✅ Token saved: ${model.token}");
        }

        return model;
      } else {
        print("❌ Login failed: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Login error: $e");
      return null;
    }
  }
}
