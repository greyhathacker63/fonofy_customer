

import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:fonofy/models/CartListModel/CartListModel.dart';
import 'package:http/http.dart' as http;

class CartListService {
  static Future<List<CartListModel>?> fetchCartList(String customerId) async {
    try {
      final url = Uri.parse('$cartListUrl?CustomerId=$customerId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);


        if (decoded is List) {
          return decoded.map((e) => CartListModel.fromJson(e)).toList();
        } else if (decoded is Map && decoded['data'] is List) {

          return (decoded['data'] as List)
              .map((e) => CartListModel.fromJson(e))
              .toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
