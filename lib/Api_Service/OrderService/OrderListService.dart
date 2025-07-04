import 'dart:convert';
import 'package:fonofy/services/web_constants.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/models/OrderModel/OrderModel.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class OrderListService {
  static Future<List<OrderModel>> fetchOrders() async {
    var userCode = await TokenHelper.getUserCode();
    var token = await TokenHelper.getToken();

    // if (token == null || TokenHelper.isTokenExpired(token)) {
    //   token = await refreshToken(userCode!); // If you have a refreshToken function
    // }

    if (userCode == null) {
      throw Exception("Customer ID is missing");
    }

    final url = Uri.parse('$baseurl$b2c$Order_List?CustomerId=$userCode');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((item) => OrderModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
