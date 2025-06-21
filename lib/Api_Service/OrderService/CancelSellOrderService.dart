import 'dart:convert';
import 'package:http/http.dart' as http;

class CancelSellOrderService {
  static Future<String> cancelOrder({
    required String orderId,
    required String customerId,
    required String reason,
    required String reasonId,
    required String reasonRemark,
  }) async {
    final url = Uri.parse('https://api.fonofy.in/api/forb2c/cancel-sell-order');

    final Map<String, dynamic> body = {
      "OrderId": orderId,
      "CustomerId": customerId,
      "Reasone": reason,
      "ReasonId": int.tryParse(reasonId) ?? 0,
      "ReasonRemark": reasonRemark,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Order cancelled successfully';
      } else {
        return 'Failed to cancel order: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
