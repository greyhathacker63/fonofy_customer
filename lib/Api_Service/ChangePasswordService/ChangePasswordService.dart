

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


        return true; // success
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
