import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:fonofy/model/AddToCartModel/AddToCartModel.dart';
import '../../Services/web_constants.dart';

class AddToCartService {
  static Future<AddToCartModel?> fetchAddToCartData(String customerId) async {
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
        return addToCartModelFromJson(response.body); // ✅ Corrected line
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ Exception: $e');
      return null;
    }
  }
}
