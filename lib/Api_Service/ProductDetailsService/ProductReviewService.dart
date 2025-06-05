import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Api_Service/BaseUrl/AllBaseUrl.dart';
import '../../models/ProductReviewModel/ProductReviewModel.dart';

class ProductReviewService {
  static Future<List<ProductReviewModel>> fetchProductReviews(String productUrl) async {
    final uri = Uri.parse('$baseUrl/api/common/get-product-rating-list?Url=$productUrl');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => ProductReviewModel.fromJson(item)).toList();
      } else {
      }
    } catch (e) {
    }
    return [];
  }
}
