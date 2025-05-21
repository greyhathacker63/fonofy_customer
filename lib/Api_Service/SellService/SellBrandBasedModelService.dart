import 'package:fonofy/model/SellModel/SellBrandBasedModel.dart';
import 'package:http/http.dart' as http;

import '../BaseUrl/AllBaseUrl.dart';

class SellBrandBasedModelService {
  static Future<List<SellBrandBasedModel>> fetchSellModelsByBrand(String brandName) async {

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