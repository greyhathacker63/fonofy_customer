// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ChangePasswordService {
//   static const String _baseUrl = "https://api.fonofy.in/api/forb2c";
//
//   static Future<bool> changePassword(String userCode, String password, String token) async {
//     final url = Uri.parse("$_baseUrl/change-password");
//
//     print("🔁 Sending password change request to: $url");
//     print("📦 Payload: CustomerId: $userCode");
//     print("📦 Payload: password: $password");
//     print("📦 Payload: Token: $token");
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({
//           "CustomerId": userCode,
//           "password": password,
//         }),
//       );
//       if (response.statusCode == 200) {
//         print("✅ Status Code: ${response.statusCode}");
//         print("📨 Response: ${response.body}");
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print("❌ Exception while changing password: $e");
//       return false;
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../BaseUrl/AllBaseUrl.dart';

class ChangePasswordService {
  static Future<bool> changePassword({
    required String customerId,
    required String newPassword,
     required String token,
  }) async {


    final body = {
      "CustomerId": customerId,
      "Password": newPassword,
    };

    try {
      final response = await http.post(Uri.parse(changePasswordUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Optional: handle based on API structure
        print("Response: $responseData");

        return true; // success
      } else {
        print("Failed with status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
