import 'dart:convert';
import 'package:fonofy/Services/web_constants.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/OrderModel/OrderListModel.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class OrderListService {
  static Future<List<OrderListModel>> fetchOrders() async {
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
      return data.map((item) => OrderListModel.fromJson(item)).toList();
    } else {
      print("Failed with status: ${response.statusCode}");
      print("Body: ${response.body}");
      throw Exception('Failed to load orders');
    }
  }
}
