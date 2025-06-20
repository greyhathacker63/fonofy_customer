import 'dart:convert';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/SellModel/SellModel.dart';
import 'package:http/http.dart' as http;
import 'package:fonofy/Services/web_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellOrderListService {
  static Future<List<SellModel>> fetchSellOrdersList(String customerId) async {
    final token = await TokenHelper.getToken();
     final url = Uri.parse('$baseurl$b2c$sellOrderListUrl?CustomerId=$customerId');
    print(url);
    print(token);
     final prefs = await SharedPreferences.getInstance();
     final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},

    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => SellModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch order products');
    }
  }
}
  

