import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/RepairModel/BookingRepairModel.dart';
import 'package:fonofy/model/RepairModel/RepairBookingModel.dart'; // <- Make sure correct model
import 'package:http/http.dart' as http;

class RepairBookingService {
  static const String baseUrl = 'https://api.fonofy.in/api/forb2c/repair-booking';

  static Future<bool> fetchRepairBooking(RepairBookingRequestModel bookingData, String token) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl), // <- Use correct URL
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(bookingData.toJson()),
      );

      print('Repair Booking Response: ${response.statusCode}');
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['message'] == 'Successful';
      } else {
        print('Error Response: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print("Exception during booking: $e");
      return false;
    }
  }
}
