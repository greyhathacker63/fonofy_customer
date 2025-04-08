import 'dart:convert';
<<<<<<< HEAD
import 'dart:developer';

import 'package:fonofy/services/web_constants.dart';
=======

>>>>>>> vinay/users
import 'package:http/http.dart' as http;

import '../model/register_model.dart';

class RegisterService {
<<<<<<< HEAD
  static Future<RegisterModel> registerApi(
      {String? firstName,
      String? phoneNumber,
      String? email,
      String? password}) async {
    var url = baseurl + register;

    var request = http.Request('POST', Uri.parse(url));
    log(request.toString());

    var reqData = {
      "FirstName": firstName,
      "PhoneNumber": phoneNumber,
      "Email": email,
      "Password": password,
    };
    request.body = jsonEncode(reqData);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    log(jsonEncode(reqData).toString());

    if (response.statusCode == 200) {
      return RegisterModel.fromJson(data);
    } else {
      return RegisterModel.fromJson(data);
    }
  }
}
=======
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
>>>>>>> vinay/users
