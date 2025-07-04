import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:http/http.dart' as http;

import '../../models/ProductRatingModel/ProductRatingModel.dart';

class ProductRatingService {
  static Future<ProductRatingModel?> fetchProductRating(
      String productUrl) async {
    final uri = Uri.parse(
        '$baseUrl/https://api.fonofy.in/api/common/get-product-rating-avrage?Url=$productUrl');
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return ProductRatingModel.fromJson(data[0]);
        }
      } else {}
    } catch (e) {}
    return null;
  }
}
