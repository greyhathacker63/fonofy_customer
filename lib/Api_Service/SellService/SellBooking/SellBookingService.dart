import 'dart:convert';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/SellDevice/SellBookingModel.dart';
import 'package:http/http.dart' as http;

class SellBookingService {
  static const String url = 'https://api.fonofy.in/api/forb2c/sell-booking';

  static Future<bool> postSellBooking(Sellbookingmodel model) async {
    try {
      final token = await TokenHelper.getToken();
      final customerId = await TokenHelper.getUserCode();

      if (token == null || customerId == null) {
        throw Exception('Missing token or customer ID');
      }

      final requestBody = model.toJson();
      requestBody['CustomerId'] = customerId;

      // ✅ Clean up: keep 'OrderId' and 'Remark' even if empty
      requestBody.removeWhere((key, value) =>
          value == null ||
          (value is String &&
              value.trim().isEmpty &&
              key != 'OrderId' &&
              key != 'Remark') ||
          (value is List && value.isEmpty));

      print('📤 POST BODY: ${json.encode(requestBody)}');
      print('📦 HEADERS: Bearer $token');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      print('📥 RESPONSE ${response.statusCode}: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        // 🧾 Log more details in case of failure
        print('❌ API Error ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e) {
      print('❌ Exception during sell booking: $e');
      return false;
    }
  }
}
