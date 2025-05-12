import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Services/web_constants.dart';
import '../BaseUrl/AllBaseUrl.dart';

class AddToBuyNowService {
  Future<String?> fetchBuyNowData({
    required String customerId,
    required String modelId,
    required String colorId,
    required String ramId,
    required String romId,
    required String cartRef,
    required int quantity,
    required double price,
  }) async {
    try {
      final uri = Uri.parse(buyNowUrl);
      final requestBody = {
        "CustomerId": customerId,
        "Quantity": quantity,
        "ModelId": modelId,
        "Price": price,
        "ColorId": colorId,
        "RamId": ramId,
        "RomId": romId,
        "CartRef": cartRef,
      };

      print("📤 Request Body: ${jsonEncode(requestBody)}");
       String jsonData = "";
      final response = await http.post(uri, headers: headers, body: jsonEncode(requestBody));
      final body = response.body.trim();

      print("🔵 Raw Response: $body");

      if (response.statusCode == 200) {
         jsonData = json.decode(body);
        }
      else {
        print("❌ HTTP Error: ${response.statusCode}");
      }
      return jsonData;
    } catch (e) {
      print("❌ Exception in addToBuyNow: $e");
    }
    return null;

  }
}
