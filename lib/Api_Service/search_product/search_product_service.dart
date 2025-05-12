import 'dart:convert';
import 'package:fonofy/Services/web_constants.dart';
import 'package:fonofy/model/search_product_model.dart';
import 'package:http/http.dart' as http;


class SearchService {
  static Future<List<SearchProduct>> fetchSearchProducts(String query) async {
    final String url = '$baseurl$common$Search?query=$query'; 
    print('Fetching from: $url'); 

    final response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => SearchProduct.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load search products');
    }
  }
}

