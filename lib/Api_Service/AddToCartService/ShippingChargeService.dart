import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:fonofy/Services/web_constants.dart';
import 'package:fonofy/model/AddToCartModel/ShippingChargeModel.dart';
import 'package:http/http.dart' as http;

class ShippingChargeService {
  static Future<List<ShippingChargeModel>> fetchShippingChargesData(Map<String, dynamic> requestBody) async {
    final url = Uri.parse(shippingChargeUrl);

    try {
      final response = await http.post(url, headers: headers, body: jsonEncode(requestBody),);

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is List) {
          return decodedResponse.map((item) => ShippingChargeModel.fromJson(item)).toList();
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
