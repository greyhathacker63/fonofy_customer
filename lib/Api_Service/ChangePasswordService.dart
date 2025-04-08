import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangePasswordService {
  static const String _baseUrl = "https://api.fonofy.in/api/forb2c";

  static Future<bool> changePassword(String userCode, String token) async {
    final url = Uri.parse("$_baseUrl/change-password");

    print("🔁 Sending password change request to: $url");
    print("📦 Payload: CustomerId: $userCode");
    print("📦 Payload: Token: $token");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "CustomerId": userCode,
        }),
      );
      if (response.statusCode == 200) {
        print("✅ Status Code: ${response.statusCode}");
        print("📨 Response: ${response.body}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("❌ Exception while changing password: $e");
      return false;
    }
  }
}
