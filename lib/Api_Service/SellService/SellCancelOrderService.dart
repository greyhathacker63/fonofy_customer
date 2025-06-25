
import 'dart:convert';

import 'package:fonofy/model/SellModel/SellCancelOrderModel.dart';
import 'package:http/http.dart' as http;

import '../../TokenHelper/TokenHelper.dart';
import '../BaseUrl/AllBaseUrl.dart';

class SellCancelOrderService {
  static Future<SellCancelOrderModel?> cancelSellOrder({
    required String orderId,
    required String customerId,
    required String reason,
    required dynamic reasonId,
    required String reasonRemark,

  }) async {
    final token = await TokenHelper.getToken();

    try {
      final response = await http.post(
        Uri.parse(sellCancelOrderUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "OrderId": orderId,
          "CustomerId": customerId,
          "Reason": reason,
          "ReasonId": reasonId,
          "ReasonRemark": reasonRemark,
        }),
      );

      if (response.statusCode == 200) {
        final body = response.body;

        try {
          final dynamic decoded = json.decode(body);
          if (decoded is Map<String, dynamic>) {
            return SellCancelOrderModel.fromJson(decoded);
          } else if (decoded is String) {
            return SellCancelOrderModel(message: decoded);
          } else {
            print("Unexpected cancel response: $decoded");
            return null;
          }
        } catch (e) {
          print("Decode Error: $e");
          return null;
        }
      } else {
        print("Cancel Failed: ${response.statusCode} => ${response.body}");
        return null;
      }
    } catch (e) {
      print("Cancel Exception: $e");
      return null;
    }
  }
}