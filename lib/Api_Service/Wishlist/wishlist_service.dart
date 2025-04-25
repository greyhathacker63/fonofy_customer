import 'dart:convert';
import 'package:http/http.dart' as http;

class WishlistService {
  static Future<bool> addToWishlist({
    required String customerId,
    required String productId,
  }) async {
    final url = Uri.parse('https://api.fonofy.in/api/forb2c/add-product-wishlist');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "CustomerId": customerId,
        "ProductId": productId,
      }),
    );

    if (response.statusCode == 200) {
      return true; // success
    } else {
      print("Add to Wishlist Failed: ${response.body}");
      return false;
    }
  }

  static removeFromWishlist({required String customerId, required String productId}) {}
}
