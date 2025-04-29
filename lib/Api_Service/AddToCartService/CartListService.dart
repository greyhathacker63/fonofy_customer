// import 'dart:convert';
//  import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
// import 'package:http/http.dart' as http;
// import '../../model/AddToCartModel/CartListModel.dart';
//
// class CartListService {
//    static Future<CartListModel?> fetchCartList(String customerId) async {
//     try {
//       final url = Uri.parse('$cartListUrl?CustomerId=$customerId');
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         return CartListModel.fromJson(json.decode(response.body));
//       } else {
//         print('❌ HTTP Error: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('❌ Exception while fetching shipping charge: $e');
//       return null;
//     }
//   }
//
//  }
//
//
//

import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:fonofy/model/AddToCartModel/CartListModel.dart';
import 'package:http/http.dart' as http;

class CartListService {
  static Future<List<CartListModel>?> fetchCartList(String customerId) async {
    try {
      final url = Uri.parse('$cartListUrl?CustomerId=$customerId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        // Assuming the response is a JSON array
        if (decoded is List) {
          return decoded.map((e) => CartListModel.fromJson(e)).toList();
        } else if (decoded is Map && decoded['data'] is List) {
          // Or if response is wrapped like: { "data": [ ... ] }
          return (decoded['data'] as List)
              .map((e) => CartListModel.fromJson(e))
              .toList();
        } else {
          print("❌ Unexpected response format.");
          return null;
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ Exception while fetching cart list: $e');
      return null;
    }
  }
}
