
import 'dart:convert';
import 'dart:developer';
import '../../services/web_constants.dart';
import '../../models/SellVariantTableModel/SellVariantTableModel.dart';
import 'package:http/http.dart' as http;
import '../BaseUrl/AllBaseUrl.dart';

class SellVariantTableService {
  static Future<SellVariantTableModel> fetchVariantTableData(String modelno,) async {
    try {
      final uri = Uri.parse(variantTableUrl).replace(queryParameters: {
        'ModelNo': modelno,
      });

      final request = http.Request('GET', uri);
      request.headers.addAll(headers);
      log('Request: $request');

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      log('Response: $responseBody');

      final data = jsonDecode(responseBody);
      return SellVariantTableModel.fromJson(data);
    } catch (e) {
      log('Error fetching repair table data: $e');
      rethrow;
    }
  }
}
