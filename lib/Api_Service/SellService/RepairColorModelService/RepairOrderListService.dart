import 'dart:convert';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:http/http.dart' as http;

import '../../../model/RepairModel/RepairOderListModel.dart';

// class RepairOrderListService {
//   static const String baseUrl = 'https://api.fonofy.in/api/forb2c/repair-order-list';
//
//   static Future<List<RepairOderListModel>> fetchRepairOrdersList(String customerId) async {
//     final url = Uri.parse('$baseUrl?CustomerId=$customerId');
//
//     final token = TokenHelper.getToken();
//
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final List<dynamic> body = jsonDecode(response.body);
//       return body.map((e) => RepairOderListModel.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load repair orders');
//     }
//   }
// }

class RepairOrderListService {
  static const String baseUrl = 'https://api.fonofy.in/api/forb2c/repair-order-list';

  static Future<List<RepairOderListModel>> fetchRepairOrdersList(String customerId) async {
    final token = await TokenHelper.getToken();
    final url = Uri.parse('$baseUrl?CustomerId=$customerId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((e) => RepairOderListModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load repair orders: ${response.statusCode}');
    }
  }
}

