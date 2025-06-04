import 'dart:convert';
import 'package:fonofy/models/ProductDetailsListModel/ProductDetailsListModel.dart';
import 'package:http/http.dart' as http;
import '../../services/web_constants.dart';
import '../BaseUrl/AllBaseUrl.dart';

class ProductDetailsListService {
  Future<List<ProductDetailsListModel>> fetchProductDetailsListData() async {
    try {
      var url = Uri.parse(productDetailsUrl);
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({}),
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        if (decodedResponse is List) {
          return decodedResponse
              .map<ProductDetailsListModel>((item) =>
              ProductDetailsListModel.fromJson(item))
              .toList();
        } else if (decodedResponse is Map &&
            decodedResponse.containsKey('result') &&
            decodedResponse['result'] is List) {
           return (decodedResponse['result'] as List)
              .map<ProductDetailsListModel>(
                  (item) => ProductDetailsListModel.fromJson(item))
              .toList();
        } else {
          // print("❌ Error: Unexpected data format");
          return [];
        }
      } else {
        // print('❌ Error: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      // print('❌ Exception: $e');
      return [];
    }
  }
}
