import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/Services/web_constants.dart';
import 'package:fonofy/model/wishlist_model.dart';
import 'package:http/http.dart' as http;
import '../../TokenHelper/TokenHelper.dart';

class WishlistService {
  static Future<List<WishlistModel>> fetchWishlist() async {
    var userCode = await TokenHelper.getUserCode(); // Get the registered mobile number
    
    var token = await TokenHelper.getToken(); // Get JWT token

   // Example usage in WishlistService
if (token == null || TokenHelper.isTokenExpired(token)) {
  token = await refreshToken(userCode!); // If token expired, refresh it
}

    final String url = "$baseurl$b2c$wishlist?CustomerId=$userCode";

    var request = http.Request('GET', Uri.parse(url));
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    request.headers.addAll(header);

    try {
      http.StreamedResponse response = await request.send();
      var responseBody = await response.stream.bytesToString();
      log(responseBody); // Log the response for debugging

      if (response.statusCode == 200) {
        var data = jsonDecode(responseBody);
        return (data as List)
            .map((item) => WishlistModel.fromJson(item))
            .toList();
      } else if (response.statusCode == 401) {
        // Handle token expiry, refresh token and retry API call
        token = await refreshToken(userCode!); // Refresh token
        return await fetchWishlist(); // Retry the API call with the new token
      } else {
        throw Exception('Failed to load wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching wishlist: $e');
    }
  }

  // Method to refresh token using the user mobile number (customerId)
  static Future<String> refreshToken(String userCode) async {
    // API endpoint to refresh token using mobile number and OTP
    final String refreshTokenUrl = "$baseurl/refresh-token"; // Replace with actual URL
    
    // Send mobile number for OTP-based login
    var response = await http.post(
      Uri.parse(refreshTokenUrl),
      body: jsonEncode({
        'mobile': userCode, // Pass registered mobile number
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String newToken = data['token']; // Assuming response contains new token
      await TokenHelper.saveToken(newToken); // Save new token to local storage
      return newToken;
    } else {
      throw Exception('Failed to refresh token: ${response.statusCode}');
    }
  }

  // Check if the token is expired (e.g., you can use expiration time from token payload)
  static bool isTokenExpired(String token) {
    // This is just an example logic. You can decode JWT and check expiration date
    try {
      var decodedToken = jsonDecode(token);
      var exp = decodedToken['exp']; // Assuming 'exp' is in seconds
      var expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return expiryDate.isBefore(DateTime.now());
    } catch (e) {
      return true; // Assume expired if unable to decode
    }
  }
}
