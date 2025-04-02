import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../AccountDetailsModel/account_details_model.dart';

// class AccountApiService {
//   static const String accountApiUrl = "https://api.fonofy.in/api/common/get-register-data?mobileNumber=";
//
//   Future<AccountDetailsModel?> getAccountData(String phoneNumber) async {
//     final url = Uri.parse("$accountApiUrl$phoneNumber");
//     print("📡 Fetching Account Details from: $url");
//
//     try {
//       final response = await http.get(url);
//       print("🛜 API Response Code: ${response.statusCode}");
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//
//         print("📥 API Response Data: $jsonResponse");
//         return AccountDetailsModel.fromJson(jsonResponse);
//       } else {
//         print("❌ Error: Failed to fetch data. Status Code: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("❌ Exception in API Call: $e");
//       return null;
//     }
//   }
// }

class AccountApiService {
  static const String baseUrl = "https://api.fonofy.in/api/common/get-register-data?mobileNumber=";

  /// Fetch Account Data from API
  Future<AccountDetailsModel?> getAccountData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? phoneNumber = prefs.getString("number");

      if (phoneNumber == null || phoneNumber.isEmpty) {
        print("⚠️ No phone number found in SharedPreferences");
        return null;
      }
      final url = Uri.parse("$baseUrl$phoneNumber");
      print("📡 Fetching Account Details from: $url");
      // ✅ Bypass SSL verification for development (Remove in production)
      HttpOverrides.global = CustomHttpOverrides();

      // API Request
      final response = await http.get(url);
      print("🛜 API Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse != null && jsonResponse["UserCode"] != null) {
          print("📥 API Response Data: $jsonResponse");
          return AccountDetailsModel.fromJson(jsonResponse);
        } else {
          print("⚠️ Invalid Response Data: $jsonResponse");
          return null;
        }
      } else {
        print("❌ Error: Failed to fetch data. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Exception in API Call: $e");
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


