import 'dart:convert';
import 'package:fonofy/services/web_constants.dart';
import 'package:fonofy/models/SearchProductModel/SearchProductModel.dart';
import 'package:http/http.dart' as http;


class SearchService {
  static Future<List<SearchProductModel>> fetchSearchProducts(String query) async {
    final String url = '$baseurl$common$Search?query=$query'; 
    // print('Fetching from: $url'); 

    final response = await http.get(Uri.parse(url));
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => SearchProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load search products');
    }
  }
}

