import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/AddToCartModel/ShippingChargeModel.dart';
import '../BaseUrl/AllBaseUrl.dart';

class ShippingChargeService {
  static Future<ShippingChargeModel?> fetchShippingCharge() async {
    try {
      var url = Uri.parse(shippingChargeUrl); // shippingChargeUrl constant hona chahiye
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return ShippingChargeModel.fromJson(json.decode(response.body));
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ Exception while fetching shipping charge: $e');
      return null;
    }
  }
}
