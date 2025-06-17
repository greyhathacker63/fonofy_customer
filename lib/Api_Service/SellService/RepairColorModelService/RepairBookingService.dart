import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../TokenHelper/TokenHelper.dart';
import '../../../model/RepairModel/RepairBookingModel.dart';

class RepairBookingService {

  static Future<bool> fetchRepairBooking(RepairBookingModel bookingData, String token) async {
    try {
      final response = await http.post(
        Uri.parse(repairBookingdUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(bookingData.toJson()),
      );

      print('Repair Booking Response: ${response.statusCode}');
      print(response.body);

      if (response.statusCode == 200) {
        return true;
      } else {
        Get.snackbar("Error", "Failed: ${response.body}",
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      print('❌ Exception: $e');
      Get.snackbar("Error", "Something went wrong: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }
}
