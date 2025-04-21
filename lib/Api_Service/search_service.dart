// search_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fonofy/model/ProductModel.dart';

class SearchService {
  static Future<List<ProductModel>> fetchAllProducts({
    required String category,
    required String productpage,
    required String customerId,
    required String ramUrl,
    required String romUrl,
    required String minPrice,
    required String maxPrice,
    required String pageCount,
  }) async {
    const String apiUrl = "https://api.fonofy.in/api/common/get-all-product-list"; // Update the API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse JSON response and map to ProductModel
        final List<dynamic> productList = json.decode(response.body);
        return productList.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
