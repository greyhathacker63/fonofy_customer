import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/RepairModel/RepairBookingModel.dart';



class RepairBookingService {
  static const String baseUrl = 'https://api.fonofy.in/api/forb2c/repair-booking';

  static Future<bool> submitRepairBooking({
    required String token,
    required RepairBookingModel bookingModel,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: repairBookingModelToJson(bookingModel),
      );

      if (response.statusCode == 200) {
        print("✅ Booking Success: ${response.body}");
        return true;
      } else {
        print("❌ Booking Failed: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("❌ Exception in Booking: $e");
      return false;
    }
  }
}
