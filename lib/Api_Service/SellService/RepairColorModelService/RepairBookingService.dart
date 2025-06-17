

//
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../../../model/RepairModel/RepairBookingModel.dart';
// import '../../BaseUrl/AllBaseUrl.dart';
//
// class RepairBookingService {
//
//   static Future<Map<String, dynamic>> submitRepairBooking({
//     required String token,
//     required RepairBookingModel bookingModel,
//   }) async {
//       {
//       final response = await http.post(Uri.parse(repairBookingdUrl),
//         headers: {
//         'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(bookingModel.toJson()),
//       );
//       print('Raw API Response: ${response.statusCode} - ${response.body}');
//
//       dynamic responseBody;
//       try {
//         responseBody = jsonDecode(response.body);
//       } catch (e) {
//         print('JSON Decode Error: $e');
//         responseBody = null;
//       }
//
//       if (response.statusCode == 200) {
//         print('✅ Booking Success: ${response.body}');
//         return {
//           'success': true,
//           'data': responseBody is Map<String, dynamic> ? responseBody : {},
//         };
//       } else {
//         print('❌ Booking Failed: ${response.statusCode} - ${response.body}');
//         List<String> errors = [];
//         if (responseBody is List<dynamic>) {
//           errors = List<String>.from(
//               responseBody.where((e) => e is String && e.isNotEmpty));
//         } else if (responseBody is Map<String, dynamic>) {
//           errors = responseBody['errors'] is List
//               ? List<String>.from(responseBody['errors'])
//               : [responseBody['message'] ?? 'Unknown error'];
//         } else {
//           errors = ['Invalid response format'];
//         }
//         return {
//           'success': false,
//           'errors': errors.isNotEmpty ? errors : ['Unknown error'],
//         };
//       }
//     }
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fonofy/model/RepairModel/RepairBookingModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../TokenHelper/TokenHelper.dart';
import '../../BaseUrl/AllBaseUrl.dart';



class RepairBookingService {
  // static const String repairBookingdUrl = 'https://api.fonofy.in/api/forb2c/repair-booking';

  static Future<bool> repairBooking(RepairBookingModel repairBookingData) async {
    try {
      final url = Uri.parse(repairBookingdUrl);
      final token = await TokenHelper.getToken();

      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "Authentication token missing", backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }

      final jsonBody = jsonEncode(repairBookingData.toJson());

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        print("✅ Repair Booking Successfully");
        return true;
      } else {
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['message'] ?? "Failed to place Repair Booking";

        Get.snackbar("Error", errorMessage, backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      print("❌ Exception in Repair Booking: $e");
      Get.snackbar("Error", "Network error: $e", backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }
}
