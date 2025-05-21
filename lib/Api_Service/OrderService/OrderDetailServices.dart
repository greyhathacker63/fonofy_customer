import 'dart:convert';
import 'package:fonofy/model/OrderModel/OrderProduct&DetailModel.dart';
import 'package:http/http.dart' as http;

import 'package:fonofy/Services/web_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailService {
  static Future<List<OrderProductModel>> fetchOrderProducts(String orderId, String customerId) async {
    final url = Uri.parse('$baseurl$b2c/order-product-list?OrderId=$orderId&CustomerId=$customerId');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => OrderProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch order products');
    }
  }

  static Future<OrderDetailModel> fetchOrderDetails(String orderId) async {
    final url = Uri.parse('$baseurl$b2c/order-details-for-check?OrderId=$orderId');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return OrderDetailModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch order details');
    }
  }

static Future<bool> cancelOrder(String orderId, String comment) async {
  final url = Uri.parse(
    '$baseurl$b2c/cancel-order?OrderId=$orderId&Comment=$comment',
  );

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    print('Failed to cancel order: ${response.statusCode} ${response.body}');
    return false;
  }
}

}
