// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../../model/RepairModel/RepairBookingModel.dart';
//
// class RepairBookingService {
//   static const String baseUrl = 'https://api.fonofy.in/api/forb2c/repair-booking';
//
//   static Future<Map<String, dynamic>> submitRepairBooking({
//     required String token,
//     required RepairBookingModel bookingModel,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse(baseUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(bookingModel.toJson()),
//       );
//
//       print('Raw API Response: ${response.statusCode} - ${response.body}');
//
//       final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
//
//       if (response.statusCode == 200) {
//         print('✅ Booking Success: ${response.body}');
//         return {
//           'success': true,
//           'data': responseBody,
//         };
//       } else {
//         print('❌ Booking Failed: ${response.statusCode} - ${response.body}');
//         return {
//           'success': false,
//           'errors': responseBody['errors'] is List
//               ? List<String>.from(responseBody['errors'])
//               : [responseBody['message'] ?? 'Unknown error'],
//         };
//       }
//     } catch (e) {
//       print('❌ Exception in Booking: $e');
//       return {
//         'success': false,
//         'errors': ['API call failed: $e'],
//       };
//     }
//   }
// }


import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/RepairModel/RepairBookingModel.dart';

class RepairBookingService {
  static String baseUrl = 'https://api.fonofy.in/api/forb2c/repair-booking';

  static Future<Map<String, dynamic>> submitRepairBooking({
    required String token,
    required RepairBookingModel bookingModel,
  }) async {
      {
      final response = await http.post(Uri.parse(baseUrl),
        headers: {
        'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(bookingModel.toJson()),
      );

      print('Raw API Response: ${response.statusCode} - ${response.body}');

      dynamic responseBody;
      try {
        responseBody = jsonDecode(response.body);
      } catch (e) {
        print('JSON Decode Error: $e');
        responseBody = null;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Booking Success: ${response.body}');
        return {
          'success': true,
          'data': responseBody is Map<String, dynamic> ? responseBody : {},
        };
      } else {
        print('❌ Booking Failed: ${response.statusCode} - ${response.body}');
        List<String> errors = [];
        if (responseBody is List<dynamic>) {
          errors = List<String>.from(
              responseBody.where((e) => e is String && e.isNotEmpty));
        } else if (responseBody is Map<String, dynamic>) {
          errors = responseBody['errors'] is List
              ? List<String>.from(responseBody['errors'])
              : [responseBody['message'] ?? 'Unknown error'];
        } else {
          errors = ['Invalid response format'];
        }
        return {
          'success': false,
          'errors': errors.isNotEmpty ? errors : ['Unknown error'],
        };
      }
    }
  }
}
