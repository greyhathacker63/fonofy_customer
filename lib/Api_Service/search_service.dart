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
    String apiUrl;

    // Generate URL for API call
    if (productpage != null && productpage.isNotEmpty) {
      apiUrl = "$baseurl$common$productList?productpage=$productpage";
    } else if (category != null && category.toLowerCase() != 'viewall') {
      apiUrl = "$baseurl$common$productList?category=$category";
    } else {
      apiUrl = "$baseurl$common$productList";
    }

    log("API URL: $apiUrl");
    
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Check if the response contains a valid product list
        if (data is List && data.isNotEmpty) {
          // Return the list of products if found
          return data.map((json) => ProductModel.fromJson(json)).toList();
        } else {
          // Return an empty list if no products are found
          return [];
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
