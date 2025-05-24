import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/model/SellModel/SellVariantPriceModel.dart';
import '../../Services/web_constants.dart';
 import 'package:http/http.dart' as http;
import '../BaseUrl/AllBaseUrl.dart';

class SellVariantPriceService {
  static Future<SellVariantPriceModel> fetchVariantPriceData(String modelNo,String ram, String rom) async {
    try {
      final uri = Uri.parse(variantPriceUrl).replace(queryParameters: {
        'ModelNo': modelNo,
        'ramName': ram,
        'romName': rom,
      });

      final request = http.Request('GET', uri);
      request.headers.addAll(headers);
      log('Request: $request');

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      log('Response: $responseBody');

      final data = jsonDecode(responseBody);
      return SellVariantPriceModel.fromJson(data);
    } catch (e) {
      log('Error fetching repair table data: $e');
      rethrow;
    }
  }
}
