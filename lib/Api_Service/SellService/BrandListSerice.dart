import 'dart:convert';
 import 'package:http/http.dart' as http;

import '../../models/BrandListModel/BrandListModel.dart';
import '../BaseUrl/AllBaseUrl.dart';

// class BrandListService {
//   static Future<List<BrandListModel>> fetchBrandList() async {
//
//     try {
//       final url = Uri.parse(sellBrandListUrl);
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         final List<dynamic> data = jsonData['data'] ?? [];
//         return data.map((item) => BrandListModel.fromJson(item)).toList();
//       } else {
//         throw Exception('Failed to load brands');
//       }
//     } catch (e) {
//       throw Exception('Error fetching brand list: $e');
//     }
//   }
// }


class BrandListService {
  static Future<List<BrandListModel>> fetchBrandList() async {
    try {
      final response = await http.get(Uri.parse(sellBrandListUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => BrandListModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load brands: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching brand list: $e');
    }
  }
}
