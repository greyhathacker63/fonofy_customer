import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/register_model.dart';

class RegisterService {
  static const String registerApiUrl = "https://api.fonofy.in/api/forb2c/register";

  Future<RegisterModel> registerApi(String registerData) async {

    try {
      final response = await http.post(
        Uri.parse(registerApiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: registerData,
      );
      print(registerData);

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        // Corrected from using a constructor to calling fromJson directly
        return RegisterModel.fromJson(jsonDecode(response.body));
      } else {
        print("Error: ${response.body}");
        throw Exception('Failed to register');
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception('Failed to register: $e');
    }
  }
}
