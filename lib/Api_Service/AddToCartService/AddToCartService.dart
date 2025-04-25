import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:fonofy/model/AddToCartModel/AddToCartModel.dart';
import 'package:http/http.dart' as http;
import '../../Services/web_constants.dart';

class AddToCartService {
  Future<List<AddToCartModel>> fetchAddToCartData(String customerId) async {
    try {
      var url = Uri.parse(addToCartUrl);
      final Map<String, dynamic> requestBody = {
        "ProductId": 0,
        "CustomerId": customerId,
        "Quantity": 3,
        "ModelId": 4,
        "BrandId": 5,
        "ColorId": 6,
        "RamId": 7,
        "RomId": 8,
        "CartRef": ""
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
              .map((item) => AddToCartModel.fromJson(item))
              .toList();
        } else {
          print("❌ Unexpected response format");
          return [];
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('❌ Exception: $e');
      return [];
    }
  }
}
