import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  final String baseUrl = "https://api.fonofy.in/api/common";


  Future<Map<String, dynamic>> checkMobileNumber(String number) async {
    try {
      final apiUrl = "https://api.fonofy.in/api/common/get-register-data?mobileNumber=$number";
      final url = Uri.parse(apiUrl);

       final httpClient = HttpClient();
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      final request = await httpClient.getUrl(url);
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        return json.decode(responseBody);
      } else {
        throw Exception("Failed to load data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
  /// ✅ Send OTP to Mobile Number
  Future<Map<String, dynamic>> getOtp(String phoneNumber) async {
    final Uri url = Uri.parse("$baseUrl/sendotp?mobileNumber=$phoneNumber");
    try {
      final httpClient = HttpClient();
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      final request = await httpClient.getUrl(url);
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        var data = jsonDecode(responseBody);
        // print("📩 OTP Sent Successfully: ${data['otp']}");
        return {"otp": data['otp'], "status": true};
      } else {
        // print("❌ Failed to Send OTP: ${response.statusCode}");
        return {"status": false};
      }
    } catch (e) {
      // print("❌ Exception in getOtp: $e");
      return {"status": false};
    }
  }

  Future<bool> verifyOTP({required String userOTP, required String otp, required String phoneNumber}) async {
    if (userOTP == otp) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("number", phoneNumber);
        // print("✅ OTP Verified & Number Saved Locally: $phoneNumber");
        return true;
      } catch (e) {
        // print("❌ Exception in verifyOTP: $e");
        return false;
      }
    }
    // print("❌ OTP Mismatch - Verification Failed");
    return false;
  }
}