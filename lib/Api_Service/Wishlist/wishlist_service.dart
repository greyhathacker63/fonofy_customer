import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/services/web_constants.dart';
import 'package:fonofy/models/WishlistModel/WishlistModel.dart';
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
    final String refreshTokenUrl = "$baseurl/refresh-token"; // Replace with actual URL

    var response = await http.post(
      Uri.parse(refreshTokenUrl),
      body: jsonEncode({'mobile': userCode}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String newToken = data['token']; 
      await TokenHelper.saveToken(newToken); 
      return newToken;
    } else {
      throw Exception('Failed to refresh token: ${response.statusCode}');
    }
  }

  static bool isTokenExpired(String token) {
    try {
      var decodedToken = jsonDecode(token);
      var exp = decodedToken['exp']; 
      var expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return expiryDate.isBefore(DateTime.now());
    } catch (e) {
      return true; 
    }
  }

  static Future<bool> addToWishlist({
    required String productId,
    int? quantity,
    int? modelId,
    int? brandId,
    required String colorId,
    required String ramId,
    required String romId,
    String? cartRef,
    
  }) async {
    var userCode = await TokenHelper.getUserCode();
    final String url = "$baseurl$b2c$addtoWishlist";
    

    var token = await TokenHelper.getToken();

    if (token == null) {
      return false;
    }

    var body = jsonEncode({
      "ProductId": int.parse(productId),
      "CustomerId": userCode,
      "Quantity": quantity,
      "ModelId": modelId,
      "BrandId": brandId,
      "ColorId": int.parse(colorId),
      "RamId": int.parse(ramId),
      "RomId": int.parse(romId),
      "CartRef": cartRef ?? "",
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
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        if (res["message"] == "Product add in wish list") {
          return true;
        } else {
          return false; // Product already in wishlist
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeFromWishlist({
    required String wishlistId,
    required String modelId,
    required String colorId,
    required String ramId,
    required String romId,
  }) async {
    var userCode = await TokenHelper.getUserCode();
    final String url = "$baseurl$b2c$deleteProductList";

    var token = await TokenHelper.getToken();

    if (token == null) {
      return false;
    }

    var body = jsonEncode({
      "ProductId": int.parse(wishlistId),
      "ModelID": modelId,
      "CustomerId": userCode,
      "ColorId": int.parse(colorId),
      "RamId": int.parse(ramId),
      "RomId": int.parse(romId),
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


      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        return res["message"].toString().toLowerCase().contains("removed");
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
