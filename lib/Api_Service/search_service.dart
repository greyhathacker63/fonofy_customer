import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Search_Model.dart'; // Make sure the path is correct

class SearchService {
  static Future<List<SearchModel>> getSearchResults(String query) async {
    final url = Uri.parse('https://api.fonofy.in/api/common/get-search-compare-product?search=$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => SearchModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
