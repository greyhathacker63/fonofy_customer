import 'dart:convert';

import 'package:fonofy/models/RepairBrandListModel/RepairBrandListModel.dart';
import 'package:http/http.dart' as http;

import '../../BaseUrl/AllBaseUrl.dart';

class RepairBrandListService {
  static Future<List<RepairBrandListModel>> fetchRepairBrandList() async {
    try {
      final response = await http.get(Uri.parse(sellBrandListUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => RepairBrandListModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load brands: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching brand list: $e');
    }
  }
}