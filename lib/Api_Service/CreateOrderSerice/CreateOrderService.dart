
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fonofy/model/CreateOrderModel/CreateOrderModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../TokenHelper/TokenHelper.dart';
import '../BaseUrl/AllBaseUrl.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fonofy/model/CreateOrderModel/CreateOrderModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../TokenHelper/TokenHelper.dart';
import '../BaseUrl/AllBaseUrl.dart';

class CreateOrderService {

   static Future<bool> createOrder(CreateOrderModel orderData) async {
    try {
      final url = Uri.parse(createOrderUrl);
      final token = await TokenHelper.getToken();
      if (token == null || token.isEmpty) {
        print("❌ No token found");
        Get.snackbar(
          "Error", "Authentication token missing",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
      final jsonBody = jsonEncode(orderData.toJson());
       print("Token: $token");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonBody,
      );

      print("API Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        print("✅ Order Created Successfully");
        return true;
      } else {
        String errorMessage = "Failed to place order";
        try {
          final responseData = jsonDecode(response.body);
          errorMessage = responseData['message'] ?? errorMessage;
        } catch (_) {
          errorMessage = "Server error: ${response.body.isEmpty ? 'No details provided' : response.body}";
        }
        print("❌ Order Creation Failed: $errorMessage");
        Get.snackbar(
          "Error",
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      print("❌ Exception in createOrder: $e");
      Get.snackbar(
        "Error",
        "Network error: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

//   create order and return id
// call create order method then call next api
// pass order id and all order details api and return details

}