import 'dart:convert';
import 'package:http/http.dart' as http;

class ReviewService {
  static Future<bool> submitReview({
    required int productId,
    required String customerId,
    required String orderId,
    required String description,
    required int rating,
    required int colorId,
    required int ramId,
    required int romId,
  }) async {
    final url = Uri.parse("https://api.fonofy.in/api/forb2c/add-product-rating");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded', // Or 'application/json' if the API expects JSON
        },
        body: {
          'ProductId': productId.toString(),
          'CustomerId': customerId,
          'OrderId': orderId,
          'Description': description,
          'Rating': rating.toString(),
          'ColorId': colorId.toString(),
          'RamId': ramId.toString(),
          'RomId': romId.toString(),
        },
      );

      print("Review API response code: ${response.statusCode}");
      print("Review API response body: ${response.body}");

      // Check if response code is 200 (Success)
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Adjust this condition based on actual API response
        if (data.containsKey('success') && data['success'] == true) {
          return true;
        } else if (data.containsKey('status') && data['status'] == true) {
          return true;
        } else {
          // If the response doesn't contain the expected keys or values
          print("Unexpected response format: $data");
          return false;
        }
      } else {
        // Log the response body for debugging
        print("API Error: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Review API exception: $e");
      return false;
    }
  }
}
