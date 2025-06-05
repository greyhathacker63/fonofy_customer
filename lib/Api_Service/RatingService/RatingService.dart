import 'dart:convert';
import 'package:fonofy/services/web_constants.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:http/http.dart' as http;

class RatingService {
  static Future<http.Response> submitRatingApi({
    required int productId,
    required String orderId,
    required String description,
    required int rating,
    required int colorId,
    required int ramId,
    required int romId,
  }) async {
    var customerId = await TokenHelper.getUserCode();
    var token = await TokenHelper.getToken();

    if (customerId == null || token == null) {
      throw Exception("Customer ID or token is missing");
    }

    final url = Uri.parse('$baseurl$b2c$ratings');

    final body = jsonEncode({
      "ProductId": productId,
      "CustomerId": customerId,
      "OrderId": orderId,
      "Description": description,
      "Rating": rating,
      "ColorId": colorId,
      "RamId": ramId,
      "RomId": romId,
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    return response;
  }
}
class ProductRatingService {
  static Future<Map<String, dynamic>?> fetchProductRating({
    required int productId,
    required int ramId,
    required int romId,
    required String orderId,
  }) async {
    final token = await TokenHelper.getToken();
    final url = Uri.parse(
      '$baseurl$b2c$getRatings?ModelNo=$productId&RamId=$ramId&RomId=$romId&OrderId=$orderId',
    );

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}