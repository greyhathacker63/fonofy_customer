import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/AccountDetailsModel/AccountDetailsModel.dart';

class AccountApiService {
  static const String baseUrl = "https://api.fonofy.in/api/common/get-register-data?mobileNumber=";


  /// Fetch Account Data from API
  Future<AccountDetailsModel?> getAccountData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? phoneNumber = prefs.getString("number");

      if (phoneNumber == null || phoneNumber.isEmpty) {
        // print("⚠️ No phone number found in SharedPreferences");
        return null;
      }
      final url = Uri.parse("$baseUrl$phoneNumber");
      // print("📡 Fetching Account Details from: $url");
       HttpOverrides.global = CustomHttpOverrides();

      final response = await http.get(url);
      // print("🛜 API Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse != null && jsonResponse["UserCode"] != null) {
          // print("📥 API Response Data: $jsonResponse");
          return AccountDetailsModel.fromJson(jsonResponse);
        } else {
          // print("⚠️ Invalid Response Data: $jsonResponse");
          return null;
        }
      } else {
        // print("❌ Error: Failed to fetch data. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // print("❌ Exception in API Call: $e");
      return null;
    }
  }
}
class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}


