import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenService {
  static const String _baseUrl = "https://api.fonofy.in/api/common/token-genrate";

  Future<String?> generateToken(String mobileNumber) async {
    final Map<String, dynamic> requestBody = {
      "UserCode": "sample string 1",
      "FirstName": "sample string 2",
      "LastName": "sample string 3",
      "Email": "sample string 4",
      "PhoneNumber": "$mobileNumber",
      "Address": "sample string 6",
      "Role": "sample string 7",
      "IsActive": true,
      "IsEmailVerified": true,
      "IsPhoneVerified": true,
      "Password": "sample string 11",
      "PlatformType": "sample string 12"
    };

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        String token = data["token"];
        print("✅ Token Generated: $token");

        // Store token securely for future use (e.g., SharedPreferences)
        return token;
      } else {
        print("❌ Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return null;
    }
  }
}
