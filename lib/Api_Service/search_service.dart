// search_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/services/web_constants.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:http/http.dart' as http;
import 'package:fonofy/models/ProductModel/ProductModel.dart';

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
    String? ramName,
    String? modelID,
  }) async {
    var userCode = await TokenHelper.getUserCode();
    try {
      Map<String, String> queryParams = {};

      // Add all filters independently
      if (userCode != null && userCode.isNotEmpty) {
        queryParams['CustomerId'] = userCode;
      }

      if (productpage != null && productpage.isNotEmpty) {
        queryParams['productpage'] = productpage;
      }

      if (category != null &&
          category.isNotEmpty &&
          category.toLowerCase() != 'viewall') {
        queryParams['category'] = category;
      }

      if (ramName != null && ramName.isNotEmpty) {
        queryParams['Ramurl'] = ramName;
      }

      if (ramUrl != null && ramUrl.isNotEmpty) {
        queryParams['Ramurl'] = ramUrl;
      }

      if (romUrl != null && romUrl.isNotEmpty) {
        queryParams['Romurl'] = romUrl;
      }

      if (minPrice != null && minPrice.isNotEmpty) {
        queryParams['MinPrice'] = minPrice;
      }

      if (maxPrice != null && maxPrice.isNotEmpty) {
        queryParams['MaxPrice'] = maxPrice;
      }

      if (pageCount != null && pageCount.isNotEmpty) {
        queryParams['page_count'] = pageCount;
      }

      if (modelID != null && modelID.isNotEmpty) {
        queryParams['model_id'] = modelID;
      }

      // If no filters provided, send a default
      if (queryParams.isEmpty) {
        queryParams['Default'] = '1';
      }

      final uri = Uri.parse("$baseurl$common$productList")
          .replace(queryParameters: queryParams);


      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          return data.map((json) => ProductModel.fromJson(json)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      throw Exception('Error fetching products: $e');
    }
  }
}
