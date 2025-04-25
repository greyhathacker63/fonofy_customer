import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/AddToCartModel/CartListModel.dart';

class CartListService {
  static Future<List<CartListModel>> fetchCartList(String customerId) async {

    final url = Uri.parse('https://api.fonofy.in/api/common/get-cart-list?CustomerId=$customerId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => CartListModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load cart list');
    }
  }
}
