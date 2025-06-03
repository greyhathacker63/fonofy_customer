import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:fonofy/model/SellModel/BrandBasedModel.dart';
import 'package:http/http.dart' as http;


class SellBrandBasedModelService {
  static Future<BrandBasedResponse> fetchSellModelsByBrand(String brandName) async {
    final url = Uri.parse('$brandBasedModelUrl?barnd=$brandName');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return brandBasedModelFromJson(response.body);
      } else {
        throw Exception('Failed to load brand-based models');
      }
    } catch (e) {
      throw Exception('Error fetching models: $e');
    }
  }
}
