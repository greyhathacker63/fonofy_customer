
import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:http/http.dart' as http;
import '../../models/ProductImageListModel/ProductImageListModel.dart';

class ProductImageListService {
  static Future<List<ProductImageListModel>> fetchProductImagesList({
    required String refNo,
    required String url,
  }) async {

    try {
      final uri = Uri.parse(productImageListUrl);
      final response = await http.post(uri,
        headers: {
        'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "RefNo": refNo,
          "Url": url,
        }),
      );

      if (response.statusCode == 200) {
        return productImageListModelFromJson(response.body);
      } else {
       
        throw Exception('Failed to load product images');
      }
    } catch (e) {
      throw Exception('Error fetching product images: $e');
    }
  }
}

