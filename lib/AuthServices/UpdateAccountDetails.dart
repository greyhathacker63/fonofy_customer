import 'dart:convert';
import 'package:fonofy/models/AccountDetailsModel/AccountDetailsModel.dart';
import 'package:fonofy/services/web_constants.dart';
import 'package:http/http.dart' as http;

import '../TokenHelper/TokenHelper.dart';

class UpdateAccountDetailsService {
  final String baseUrl = baseurl + b2c + updateDetails;

  Future<Map<String, dynamic>> updateAccountDetails(
      AccountDetailsModel customer) async {
    try {
      final token = await TokenHelper.getToken();
      final userCode = await TokenHelper.getUserCode();

      final updatedCustomer =
          customer.userCode.isNotEmpty ? customer : customer;

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updatedCustomer.toJson()),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Exception: $e',
      };
    }
  }
}
