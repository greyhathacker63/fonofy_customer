import 'dart:convert';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:http/http.dart' as http;
import 'package:fonofy/Services/web_constants.dart';

class SellCalculatorService {
  Future<Map<String, dynamic>?> calculateSellPrice({
    required List<double> questWeights,
    required double basePrice,
  }) async {
    final token = await TokenHelper.getToken();

    final url = Uri.parse("$baseurl$b2c$sellCalculator");

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "QuestWeghtes": questWeights,  // ✅ Correct key (as expected by backend)
        "baseprice": basePrice         // ✅ Lowercase and exact spelling
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Sell calculation failed: ${response.statusCode}");
      print("Response: ${response.body}");
      return null;
    }
  }
}
