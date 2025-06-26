import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/model/RepairModel/BookingRepairModel.dart';
import 'package:http/http.dart' as http;

class RepairBookingService {
  static const String baseUrl =
      'https://api.fonofy.in/api/forb2c/repair-booking';

  static Future<bool> fetchRepairBooking(
      RepairBookingRequestModel bookingData, String token) async {
    try {
      final requestJson = json.encode(bookingData.toJson());
      log('Request JSON: $requestJson');

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestJson,
      );

      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is String) {
          return decoded == 'Successful';
        } else if (decoded is Map<String, dynamic>) {
          return decoded['message'] == 'Successful';
        }

        return false;
      } else {
        print('Error Response: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e, stack) {
      print("Exception during booking: $e");
      print("Stack trace: $stack");
      return false;
    }
  }
}
