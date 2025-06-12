import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/ManagePaymentsModel/BankDetailsModel.dart';
import 'package:http/http.dart' as http;
import '../Services/web_constants.dart';


class UpiService {
  static Future<bool> addUpi(String upiId) async {
    final token = await TokenHelper.getToken();
    final customerId = await TokenHelper.getUserCode();
    if (token == null || customerId == null) return false;

    const String addUpiEndpoint = "add-upi";
    final url = Uri.parse("$baseurl$b2c$addUpiEndpoint?UpiId=$upiId&CustomerId=$customerId");

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        final body = response.body.trim().replaceAll('"', '');
        return body == "Successful";
      }
      return false;
    } catch (e) {
      log("Add UPI Exception: $e");
      return false;
    }
  }

  static Future<List<UpiDetails>?> getUpiList() async {
    final token = await TokenHelper.getToken();
    final customerId = await TokenHelper.getUserCode();

    if (token == null || customerId == null) return null;

    final url = Uri.parse("$baseurl${b2c}account-detials-list?customerId=$customerId");

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data["Table1"] ?? [];
        return list.map((e) => UpiDetails.fromJson(e)).toList();
      }

      return null;
    } catch (e) {
      log("getUpiList error: $e");
      return null;
    }
  }

  static Future<bool> deleteUpi(int id) async {
    final token = await TokenHelper.getToken();
    final customerId = await TokenHelper.getUserCode();

    if (token == null || customerId == null) return false;

    final url = Uri.parse("$baseurl${b2c}delete-upi?Id=$id&CustomerId=$customerId");

    try {
      final response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final body = response.body.trim().replaceAll('"', '');
        return body == "Delete Successful";
      }

      return false;
    } catch (e) {
      log("Delete UPI Exception: $e");
      return false;
    }
  }
}
