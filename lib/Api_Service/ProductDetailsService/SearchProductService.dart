// import 'dart:convert';
//  import 'package:http/http.dart' as http;
//
// import '../../model/ProductDetailsModel/GetSearchProductsModel.dart';
// import '../../model/ProductDetailsModel/SearchCompareProductModel.dart';
//
// class SearchProductService {
//   static Future<List<GetSearchProductsModel>> fetchSearchProducts(String query) async {
//     final url = Uri.parse("https://api.fonofy.in/api/common/get-search-products?query=$query");
//
//     try {
//       final response = await http.post(url);
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         return data.map((item) => GetSearchProductsModel.fromJson(item)).toList();
//       } else {
//         throw Exception("Failed to load search results");
//       }
//     } catch (e) {
//       throw Exception("Error: $e");
//     }
//   }
//
//
//
//
//   static Future<List<SearchCompareProductModel>> fetchSearchProductsList(String query) async {
//     final url = Uri.parse("https://api.fonofy.in/api/common/get-search-compare-product?query=$query");
//     try {
//       final response = await http.post(url);
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         return data
//             .map((item) => SearchCompareProductModel.fromJson(item))
//             .toList();
//       } else {
//         throw Exception("Failed to load search results");
//       }
//     } catch (e) {
//       throw Exception("Error: $e");
//     }
//   }
// }

import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:http/http.dart' as http;
 import '../../model/ProductDetailsModel/SearchCompareProductModel.dart';


class SearchProductService {
  static Future<List<SearchCompareProductModel>> fetchSearchProductsList(String query) async {
    final uri = Uri.parse('$searchCompareProductUrl?query=$query');

    try {
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> data = body['data'];
        return data.map((item) => SearchCompareProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load product details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
