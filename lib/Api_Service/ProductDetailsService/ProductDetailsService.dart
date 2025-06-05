import 'dart:convert';
import 'package:fonofy/models/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:http/http.dart' as http;
import '../../services/web_constants.dart';
import '../BaseUrl/AllBaseUrl.dart';

class ProductDetailsService {
  Future<List<ProductDetailsModel>> fetchProductDetailsData({
    required String Url,
    required String Refno,
  }) async {
    try {
      var url = Uri.parse(productDetailsUrl);
      final Map<String, dynamic> requestBody = {
        "Url": Url,
        "Refno": Refno,
      };

       var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is List) {
          return decodedResponse
              .map((item) => ProductDetailsModel.fromJson(item))
              .toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
