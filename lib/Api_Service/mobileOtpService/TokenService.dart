import 'dart:convert';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
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
      
        return token;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
