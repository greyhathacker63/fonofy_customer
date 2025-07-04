import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:http/http.dart' as http;

import '../../models/SearchCompareProductModel/SearchCompareProductModel.dart';




class SearchProductService {
  static Future<List<SearchCompareProductModel>> fetchSearchProductsList(String query) async {
    final url = Uri.parse("$searchCompareProductUrl?query=$query");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => SearchCompareProductModel.fromJson(item)).toList();
      } else {
        throw Exception("❌ Failed to load search results (Status Code: ${response.statusCode})");
      }
    } catch (e) {
      throw Exception("❌ Error: $e");
    }
  }
}
