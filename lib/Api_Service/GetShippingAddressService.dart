import 'dart:convert';
import 'package:http/http.dart' as http;
import '../TokenHelper/TokenHelper.dart';
import '../model/ListShippingAddressModel.dart';

class GetShippingAddressService {
  Future<List<ListShippingAddressModel>> fetchShippingAddressGetData({
    required int id,
    required String shipmentId,
  }) async {
    try {
      String? token = await TokenHelper.getToken();
      if (token == null) {
        print('❌ Error: No authentication token found.');
        return [];
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      // final idd=4;
      // final  ShippmentIdd='SIP_29032025101409AM';
      var url = Uri.parse(
          "https://api.fonofy.in/api/forb2c/get-shipping-address?Id=$id&ShippmentId=$shipmentId");
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is List) {
          return decodedResponse
              .map((item) => ListShippingAddressModel.fromJson(item))
              .toList();
        } else {
          print("❌ Error: Unexpected data format");
          return [];
        }
      } else {
        print('❌ Error: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('❌ Exception: $e');
      return [];
    }
  }
}
