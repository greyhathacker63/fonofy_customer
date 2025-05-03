import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Services/web_constants.dart';
import '../BaseUrl/AllBaseUrl.dart';

class AddToBuyNowService {
  Future<String?> fetchBuyNowData(
      String customerId,
      dynamic ramId,
      dynamic romId,
      dynamic quantity,
      dynamic colorId,
      dynamic modelId,
      ) async {
    try {
      final url = Uri.parse(buyNowUrl);
      final requestBody = {
        "CustomerId": customerId,
        "Quantity": quantity,
        "ModelId": modelId,
        "ColorId": colorId,
        "RamId": ramId,
        "RomId": romId,
        "CartRef": "4rnfdmfknsd",
      };

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print("🔵 Raw response body: ${response.body}");

      if (response.statusCode == 200) {
        final  body = jsonDecode(response.body);

        // ✅ Return only the 'Message' field
        return body;
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ Exception while adding to Buy Now: $e');
      return null;
    }
  }
}
