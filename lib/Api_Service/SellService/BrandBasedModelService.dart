import 'package:http/http.dart' as http;

import '../../models/BrandBasedModel/BrandBasedModel.dart';
import '../BaseUrl/AllBaseUrl.dart';

class RepairBrandBasedModelService {
  static Future<List<BrandBasedModel>> fetchModelsByBrand(String brandName) async {
    final url = Uri.parse('$brandBasedModelUrl?barnd=$brandName');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final brandBasedResponse = brandBasedModelFromJson(response.body);
        return brandBasedResponse.models;  // return the list inside the response
      } else {
        throw Exception('Failed to load brand-based models');
      }
    } catch (e) {
      throw Exception('Error fetching models: $e');
    }
  }
}
