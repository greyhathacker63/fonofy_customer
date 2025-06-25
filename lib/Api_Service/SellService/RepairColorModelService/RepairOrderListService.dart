import 'dart:convert';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:http/http.dart' as http;

import '../../../model/RepairModel/RepairOderListModel.dart';
import '../../BaseUrl/AllBaseUrl.dart';


// class RepairOrderListService {
//   static Future<List<RepairOderListModel>> fetchRepairOrdersList(String customerId) async {
//     final token = await TokenHelper.getToken();
//     final url = Uri.parse('$repairOrderLisUrl?CustomerId=$customerId');
//
//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final List<dynamic> body = jsonDecode(response.body);
//       return body.map((e) => RepairOderListModel.fromJson(e)).toList();
//     }
//     else {
//       throw Exception('Failed to load repair orders: ${response.statusCode}');
//     }
//   }
// }

class RepairOrderListService {
  static Future<List<RepairOderListModel>> fetchRepairOrdersList(String customerId) async {
    final token = await TokenHelper.getToken();
    final url = Uri.parse('$repairOrderLisUrl?CustomerId=$customerId');
    try {
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
         print("Repair order list not found or error: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Error fetching repair orders: $e");
      return [];
    }
  }
}


