import 'dart:convert';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsListModel.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:http/http.dart' as http;
import '../../Services/web_constants.dart';
import '../BaseUrl/AllBaseUrl.dart';

class ProductDetailsListService {
  Future<List<ProductDetailsListModel>> fetchProductDetailsListData() async {
    try {
      var url = Uri.parse(productListUrl);
      final Map<String, dynamic> requestBody = {
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
              .map((item) => ProductDetailsListModel.fromJson(item))
              .toList();
        } else {
          print("❌ Error: Unexpected data format");
          return [];
        }
      } else {
        print('❌ Error: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('❌ Exception: $e');
      return [];
    }
  }
}
