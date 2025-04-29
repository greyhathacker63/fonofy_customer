import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/Services/web_constants.dart';
import 'package:fonofy/model/wishlist_model.dart';
import 'package:http/http.dart' as http;
import '../../TokenHelper/TokenHelper.dart';

class WishlistService {
  static Future<List<WishlistModel>> fetchWishlist() async {
    var userCode = await TokenHelper.getUserCode();

    var token = await TokenHelper.getToken();

    if (token == null || TokenHelper.isTokenExpired(token)) {
      token = await refreshToken(userCode!);
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
      log(responseBody);

      if (response.statusCode == 200) {
        var data = jsonDecode(responseBody);
        return (data as List)
            .map((item) => WishlistModel.fromJson(item))
            .toList();
      } else if (response.statusCode == 401) {
        token = await refreshToken(userCode!);
        return await fetchWishlist();
      } else {
        throw Exception('Failed to load wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching wishlist: $e');
    }
  }

  static Future<String> refreshToken(String userCode) async {
    final String refreshTokenUrl =
        "$baseurl/refresh-token"; // Replace with actual URL

    // Send mobile number for OTP-based login
    var response = await http.post(
      Uri.parse(refreshTokenUrl),
      body: jsonEncode({
        'mobile': userCode,
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

  static Future<bool> addToWishlist({
    required int productId,
    required String customerId,
    required int quantity,
    required int modelId,
    required int brandId,
    required int colorId,
    required int ramId,
    required int romId,
    required String cartRef,
  }) async {
    final String url = "$baseurl$b2c$addToWishlist";

    var token = await TokenHelper.getToken();

    // Skipping token refresh for now
    if (token == null) {
      log("Token is null. Cannot proceed with wishlist POST.");
      return false;
    }

    var body = jsonEncode({
      "ProductId": productId,
      "CustomerId": customerId,
      "Quantity": quantity,
      "ModelId": modelId,
      "BrandId": brandId,
      "ColorId": colorId,
      "RamId": ramId,
      "RomId": romId,
      "CartRef": cartRef,
    });

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      log("Wishlist Add Response: ${response.body}");

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        return res["message"] == "Product add in wish list";
      } else {
        log("Add to Wishlist failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log("Add to Wishlist exception: $e");
      return false;
    }
  }
}
