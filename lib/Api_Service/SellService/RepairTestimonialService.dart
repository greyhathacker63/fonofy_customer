import 'dart:convert';

import 'package:fonofy/model/RepairModel/RepairTestimonialListModel.dart';
import 'package:fonofy/model/SellModel/SellTestimonialListModel.dart';
import 'package:http/http.dart' as http;

import '../BaseUrl/AllBaseUrl.dart';

class RepairTestimonialService{

  static Future<List<RepairTestimonialListModel>> fetchRepairTestimonialList() async {
    try {
      final response = await http.get(Uri.parse(sellTestimonialListUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => RepairTestimonialListModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load brands: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching brand list: $e');
    }
  }
}