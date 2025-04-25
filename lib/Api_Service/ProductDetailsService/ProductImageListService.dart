// import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
// import 'package:fonofy/Services/web_constants.dart';
// import 'package:http/http.dart' as http;
// import '../../model/ProductDetailsModel/ProductImageListModel.dart';
//
// class ProductImageListService {
//   static Future<List<ProductImageListModel>> fetchProductImagesList({
//     required String url,
//     required String refNo,
//   }) async {
//     try {
//       var url = Uri.parse(productImageListUrl);
//       final response = await http.post(url,body: {'refNo': refNo},
//       );
//       if (response.statusCode == 200) {
//         return productImageListModelFromJson(response.body);
//       } else {
//         throw Exception('Failed to load product images');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }

import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:http/http.dart' as http;
import '../../model/ProductDetailsModel/ProductImageListModel.dart';

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
        print("✅ API Response: ${response.body}");
        return productImageListModelFromJson(response.body);
      } else {
        print("❌ Failed with status code: ${response.statusCode}");
        print("❗ Response Body: ${response.body}");
        throw Exception('Failed to load product images');
      }
    } catch (e) {
      print("❌ Error in ProductImageListService: $e");
      throw Exception('Error fetching product images: $e');
    }
  }
}

