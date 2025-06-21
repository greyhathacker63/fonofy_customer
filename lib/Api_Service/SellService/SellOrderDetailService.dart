import 'dart:convert';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/SellModel/SellModel.dart';
import 'package:fonofy/model/SellModel/SellOrderDetailModel.dart';
import 'package:http/http.dart' as http;
import 'package:fonofy/Services/web_constants.dart';

class SellOrderDetailService {
  static Future<Map<String, dynamic>> fetchSellOrderDetail({
    required String orderId,
    required String customerId,
  }) async {
    final token = await TokenHelper.getToken();
    final url = Uri.parse(
      'https://api.fonofy.in/api/forb2c/sell-order-product-details?OrderId=$orderId&CustomerId=$customerId',
    );

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final SellOrderDetailProduct product = SellOrderDetailProduct.fromJson(data['Table'][0]);
      final SellOrderDetailInfo info = SellOrderDetailInfo.fromJson(data['Table1'][0]);

      return {
        'product': product,
        'info': info,
      };
    } else {
      throw Exception('Failed to fetch sell order details');
    }
  }
}
