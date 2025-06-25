// import 'dart:convert';
// import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//  import '../../../model/RepairModel/RepairBookingModel.dart';
//
// class RepairBookingService {
//
//   static Future<bool> fetchRepairBooking(RepairBookingModel bookingData, String token) async {
//     try {
//       final response = await http.post(
//         Uri.parse(repairBookingdUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(bookingData.toJson()),
//       );
//
//       print('Repair Booking Response: ${response.statusCode}');
//       print(response.body);
//
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         Get.snackbar("Error", "Failed: ${response.body}",
//             backgroundColor: Colors.red, colorText: Colors.white);
//         return false;
//       }
//     } catch (e) {
//       print('❌ Exception: $e');
//       Get.snackbar("Error", "Something went wrong: $e",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return false;
//     }
//   }
// }


import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../TokenHelper/TokenHelper.dart';
import '../../../model/RepairModel/RepairBookingModel.dart';

class RepairBookingService {
  static const String baseUrl = 'https://api.fonofy.in/api/forb2c/repair-booking';

  static Future<bool> submitBooking(RepairBookingModel model) async {
    final token = await TokenHelper.getToken();

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['message'] == 'Successful';
    } else {
      print('Error Response: ${response.statusCode} - ${response.body}');
      return false;
    }
  }
}

