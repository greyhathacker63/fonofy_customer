import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fonofy/model/RepairModel/BookingRepairModel.dart';

class RepairBookingService {
  static Future<void> postRepairBooking(RepairBookingRequest booking) async {
    final response = await http.post(
      Uri.parse('https://api.fonofy.in/api/forb2c/repair-booking'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(booking.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to book repair: ${response.body}');
    }
  }
}
