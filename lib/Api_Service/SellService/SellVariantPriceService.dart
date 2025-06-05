import 'dart:convert';
import 'package:fonofy/models/SellVariantPriceModel/SellVariantPriceModel.dart';
 import 'package:http/http.dart' as http;








class SellVariantPriceService {
  static Future<SellVariantPriceModel?> fetchVariantPriceData(
      String modelNo, String ram, String rom) async {
    final uri = Uri.https('api.fonofy.in','/api/common/model-variant-price',
      {
        'ModelNo': modelNo,
        'Ram': ram,
        'Rom': rom,
      },
    );


    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return SellVariantPriceModel.fromJson(data[0]);
        } else {
        }
      } else {
      }
    } catch (e) {
    }
    return null;
  }
}


