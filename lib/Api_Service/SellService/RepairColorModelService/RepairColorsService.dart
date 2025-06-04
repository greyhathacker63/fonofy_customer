
import 'package:fonofy/models/RepairModel/RepairModel.dart';
import 'package:http/http.dart' as http;

import '../../BaseUrl/AllBaseUrl.dart';




class RepairColorService {
  static Future<List<RepairModel>> fetchRepairColorList(String brandId,String modelId) async {

    final url = Uri.parse('$repairColorsUrl?brandId=$brandId&ModelId=$modelId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return repairModelFromJson(response.body);
      } else {
        throw Exception('Failed to load brand-based models');
      }
    } catch (e) {
      throw Exception('Error fetching models: $e');
    }
  }
}