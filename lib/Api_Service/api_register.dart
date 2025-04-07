import 'dart:convert';
import 'dart:developer';

import 'package:fonofy/services/web_constants.dart';
import 'package:http/http.dart' as http;

import '../model/register_model.dart';

class RegisterService {
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