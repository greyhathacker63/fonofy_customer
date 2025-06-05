import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../TokenHelper/TokenHelper.dart';
import '../../models/ListShippingAddressModel/ListShippingAddressModel.dart';

class GetShippingAddressService {
  Future<List<ListShippingAddressModel>> fetchShippingAddressGetData({
    required int id,
    required String shipmentId,
  }) async
  {
    try {
      String? token = await TokenHelper.getToken();
      if (token == null) {
        return [];
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.parse("https://api.fonofy.in/api/forb2c/get-shipping-address?Id=$id&ShippmentId=$shipmentId");
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is List) {
          return decodedResponse
              .map((item) => ListShippingAddressModel.fromJson(item))
              .toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
