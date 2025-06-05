import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/AccountDetailsModel/AccountDetailsModel.dart';

class AccountApiService {
  static const String baseUrl = "https://api.fonofy.in/api/common/get-register-data?mobileNumber=";


  /// Fetch Account Data from API
  Future<AccountDetailsModel?> getAccountData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? phoneNumber = prefs.getString("number");

      if (phoneNumber == null || phoneNumber.isEmpty) {
        return null;
      }
      final url = Uri.parse("$baseUrl$phoneNumber");
       HttpOverrides.global = CustomHttpOverrides();

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse != null && jsonResponse["UserCode"] != null) {
          return AccountDetailsModel.fromJson(jsonResponse);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
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


