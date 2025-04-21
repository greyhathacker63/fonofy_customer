// search_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:fonofy/Services/web_constants.dart';
import 'package:http/http.dart' as http;
import 'package:fonofy/model/ProductModel.dart';

class SearchService {
  static Future<List<ProductModel>> fetchAllProducts({
   String? category,
    String? productpage,
    String? customerId,
    String? ramUrl,
    String? romUrl,
    String? minPrice,
    String? maxPrice,
    String? pageCount,
  }) async {
     String apiUrl = baseurl + common + productList + "?category=$category";
     log(apiUrl.toString()); // Update the API URL

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
