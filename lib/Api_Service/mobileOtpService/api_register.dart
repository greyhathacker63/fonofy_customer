import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../TokenHelper/TokenHelper.dart';
import '../../model/RegisterModel/register_model.dart';

// class RegisterService {
//   static const String registerApiUrl = "https://api.fonofy.in/api/forb2c/register";
//
//   Future<RegisterModel> registerApi(String registerData) async {
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     try {
//       final response = await http.post(
//         Uri.parse(registerApiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: registerData,
//       );
//       print(registerData);
//
//       print("Response Status: ${response.statusCode}");
//       print("Response Body: ${response.body}");
//       if (response.statusCode == 200) {
//         // Corrected from using a constructor to calling fromJson directly
//         var jsonData = jsonDecode(response.body);
//
//        await  prefs.setString("token", jsonData["token"]);
//         return RegisterModel.fromJson(jsonData);
//
//       } else {
//         print("Error: ${response.body}");
//         throw Exception('Failed to register');
//       }
//     } catch (e) {
//       print("Exception: $e");
//       throw Exception('Failed to register: $e');
//     }
//   }
//   Future<Map<String, dynamic>> getOtpphone(String mobileNumber) async {
//     final url = Uri.parse("https://api.fonofy.in/api/common/sendotp?mobileNumber=$mobileNumber");
//     try {
//       print("API Call: $url");
//
//       final response = await http.get(url);
//       print("Response Status: ${response.statusCode}");
//       print("Response Body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         print("Decoded Response: $data");
//         return {
//           "otp": data['otp'],
//           "status": true
//         };
//       } else {
//         print("Failed to get OTP, status: ${response.statusCode}");
//         return {"status": false};
//       }
//     } catch (e) {
//       print("Error: $e");
//       return {"status": false};
//     }
//   }
//
// }
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
        var jsonData = jsonDecode(response.body);
        // Save the token using TokenHelper
        await TokenHelper.saveToken(jsonData["token"]);

        return RegisterModel.fromJson(jsonData);
      } else {
        print("Error: ${response.body}");
        throw Exception('Failed to register');
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception('Failed to register: $e');
    }
  }

  Future<Map<String, dynamic>> getOtpphone(String mobileNumber) async {
    final url = Uri.parse("https://api.fonofy.in/api/common/sendotp?mobileNumber=$mobileNumber");
    try {
      print("API Call: $url");

      final response = await http.get(url);
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("Decoded Response: $data");
        return {
          "otp": data['otp'],
          "status": true
        };
      } else {
        print("Failed to get OTP, status: ${response.statusCode}");
        return {"status": false};
      }
    } catch (e) {
      print("Error: $e");
      return {"status": false};
    }
  }
}

